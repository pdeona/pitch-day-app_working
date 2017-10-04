class User < ApplicationRecord
  validates :trello_id, presence: true, uniqueness: true

  has_many :projects
  has_and_belongs_to_many :projects, through: :collaborators
end
