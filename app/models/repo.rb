class Repo < ApplicationRecord
  belongs_to :project

  def create_new_repo user
    @client = Octokit::Client.new(access_token: user.github_oauth)
    @client.fork('pdeona/pitch_day_project_template')
    fetch_existing_repo_github_id user
  end

  def fetch_existing_repo_github_id user
    @client ||= Octokit::Client.new(access_token: user.github_oauth)
    @client.repos.each do |repo|
      if repo.name == self.name
        self.github_id = repo[:id]
        self.url = repo[:url]
      end
    end
    save! unless self.github_id.nil?
  end

end
