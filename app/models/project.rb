class Project < ApplicationRecord
  belongs_to :user
  has_many :collaborators

  validates :due_by, presence: true
end
