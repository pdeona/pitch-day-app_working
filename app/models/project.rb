class Project < ApplicationRecord
  has_and_belongs_to_many :collaborators, class_name: 'User'
  has_one :board
  has_one :repo

  validates :due_by, presence: true

  def new_project_steps user, project_params
    Project.create(project_params)
    create_project_board
  end

  def add_collaborators client, users
    users.each do |user|
      self.collaborators << user
    end
    if self.save!
      self.board.add_collaborators client, users
      self.repo.add_collaborators client, users unless self.repo.nil?
    end
  end

  private

  def create_project_board
    if self.save! && self.board.nil?
      Board.new.add_to_trello User.find(self.user_id), self
    else
      Board.find(self.board.id)
    end
  end
end
