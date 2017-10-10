class RemoveGithubRepoFromProjects < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :github_repo, :string
  end
end
