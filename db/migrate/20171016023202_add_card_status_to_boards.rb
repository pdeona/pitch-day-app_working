class AddCardStatusToBoards < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :card_status, :string
  end
end
