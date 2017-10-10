class Repo < ApplicationRecord
  belongs_to :project

  def create_new_repo name, user
    repo = Repo.create(name: name)
    client = Octokit::Client.new(access_token: user.github_oauth)
    client.repos.create

  def fetch_existing_repo_github_id user
    client = Octokit::Client.new(access_token: user.github_oauth)
    client.repos.each do |repo|
      if repo.name == self.name
        self.github_id = repo[:id]
      end
    end
    self.save!
  end

end
