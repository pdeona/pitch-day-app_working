class AddGithubRepoToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :github_repo, :string
  end
end
