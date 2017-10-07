class AddTrelloMemberTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :trello_member_token, :string
    add_column :users, :trello_member_secret, :string
  end
end
