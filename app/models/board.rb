class Board < ApplicationRecord
  belongs_to :project

  validates :trello_id, presence: true

  def make_new_board

end
