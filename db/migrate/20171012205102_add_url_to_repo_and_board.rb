class AddUrlToRepoAndBoard < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :url, :string
    add_column :repos, :url, :string
  end
end
