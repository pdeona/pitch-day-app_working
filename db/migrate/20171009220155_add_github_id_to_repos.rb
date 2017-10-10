class AddGithubIdToRepos < ActiveRecord::Migration[5.1]
  def change
    add_column :repos, :github_id, :string
    add_column :repos, :name, :string
  end
end
