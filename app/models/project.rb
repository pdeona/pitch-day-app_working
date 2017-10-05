class Project < ApplicationRecord
  has_and_belongs_to_many :collaborators, class_name: 'User'
  has_one :board

  validates :due_by, presence: true
end
