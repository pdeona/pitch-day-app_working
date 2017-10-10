class AddOwnerToUserProjectJoinTable < ActiveRecord::Migration[5.1]
  def change
    add_column :projects_users, :owner, :boolean
  end
end
