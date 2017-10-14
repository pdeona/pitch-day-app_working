class Repo < ApplicationRecord
  belongs_to :project

  def self.link_existing_repo user, project, repo_name
    repo = Repo.new(name: project.name, project_id: project.id)
    @client = Octokit::Client.new(access_token: user.github_oauth)
    github_repo = @client.repo(user.github_id + '/' + repo_name)
    if github_repo
        repo.github_id = github_repo[:id]
        repo.url = github_repo[:url]
    end
    res = repo.save! unless repo.github_id.nil?
    res ? repo : 'Github link failed'
  end

  def add_collaborators user, collaborators
    @client = Octokit::Client.new(access_token: user.github_oauth)
    collaborators.each do |collaborator|
      github_user = collaborator.github_id
      @client.put('/repos/#{user.github_id}/#{self.name}/collaborators/#{github_user}')
    end
  end

end
