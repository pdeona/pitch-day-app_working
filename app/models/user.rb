class User < ApplicationRecord
  validates :trello_id, presence: true, uniqueness: true

end
