class AddOauthTokensToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :github_oauth, :string
    add_column :users, :trello_oauth, :string
    add_column :users, :trello_oauth_verifier, :string
  end
end
