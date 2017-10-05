class Board < ApplicationRecord
  belongs_to :project

  validates :trello_id, presence: true
end
