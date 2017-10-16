class Project < ApplicationRecord
  has_and_belongs_to_many :collaborators, class_name: 'User'
  has_one :board
  has_one :repo
  belongs_to :user

  validates :due_by, presence: true

  def new_project_steps user, project_params
    @project = Project.new(project_params)
    @project.user_id = user.id
    if @project.save
      create_project_board user
    end
    @project
  end

  def add_collaborators client, users
    users.each do |user|
      self.collaborators << user unless user.id == self.user_id
    end
    if self.save!
      self.board.add_collaborators client, users
      self.repo.add_collaborators client, users unless self.repo.nil?
    end
  end

  private

  def create_project_board user
    Board.new.add_to_trello user, @project
  end
end
