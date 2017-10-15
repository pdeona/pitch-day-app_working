class AddLangsToRepo < ActiveRecord::Migration[5.1]
  def change
    add_column :repos, :langs, :string
  end
end
