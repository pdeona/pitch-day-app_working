class User < ApplicationRecord
  validates :github_id, presence: true, uniqueness: true

  has_and_belongs_to_many :projects

  def self.fetch_trello_name trello_name
    Trello::Member.find(trello_name).username
  end


  def self.create_from_github auth
    User.create!(
      github_id: auth['uid'],
      email: auth['info']['email']
    )
  end

  def self.create_from_trello auth
    User.create_with(trello_id: auth['email']).find_or_create_by(
      email: auth['email']
    )
  end
end
