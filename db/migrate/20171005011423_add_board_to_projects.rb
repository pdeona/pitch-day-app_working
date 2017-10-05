class AddBoardToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :project_id, :integer
  end
end
