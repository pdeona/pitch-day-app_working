class Repo < ApplicationRecord
  belongs_to :project

  def link_existing_repo user
    @client = Octokit::Client.new(access_token: user.github_oauth)
    @client.repos.each do |repo|
      if repo.name == self.name
        self.github_id = repo[:id]
        self.url = repo[:url]
      end
    end
    res = save! unless self.github_id.nil?
    res ? self : 'Github link failed'
  end

  def add_collaborators user, collaborators
    @client = Octokit::Client.new(access_token: user.github_oauth)
    collaborators.each do |collaborator|
      github_user = collaborator.github_id
      @client.put('/repos/#{user.github_id}/#{self.name}/collaborators/#{github_user}')
    end
  end

end
