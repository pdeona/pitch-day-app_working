class AddDueDateAndNameToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :name, :string
    add_column :projects, :due_by, :date
  end
end
