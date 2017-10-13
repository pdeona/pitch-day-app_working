class User < ApplicationRecord
  validates :github_id, presence: true, uniqueness: true

  has_and_belongs_to_many :projects

  def self.create_from_github info
    User.create!(
      github_id: info['nickname'],
      email: info['email'],
      image: '/doge.jpg'
    )
  end

  def connect_to_trello auth
    try(self.trello_id = auth.info.nickname)
  end

end

