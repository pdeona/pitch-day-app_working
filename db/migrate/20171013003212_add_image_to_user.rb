class AddImageToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :image, :string
    add_column :users, :ruby, :integer
    add_column :users, :javascript, :integer
    add_column :users, :html, :integer
    add_column :users, :css, :integer
  end
end
