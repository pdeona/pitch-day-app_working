class AddIndexOnTrelloId < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :trello_id, unique: true
  end
end
