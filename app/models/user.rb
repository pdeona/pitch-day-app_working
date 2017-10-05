class User < ApplicationRecord
  validates :trello_id, presence: true, uniqueness: true

  has_and_belongs_to_many :projects
end
