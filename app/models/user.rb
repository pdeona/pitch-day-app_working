class User < ApplicationRecord
  validates :trello_id, presence: true, uniqueness: true

  has_and_belongs_to_many :projects
  # has_many :providers

  devise :omniauthable, omniauth_providers: [:trello, :github]

  # def self.fetch_trello_name trello_name
  #   Trello::Member.find(trello_name).username
  # end

  # def self.trello_oauth_token_set auth
  #   user = User.find_by(trello_id: auth.info.email) || User.create_from_trello(auth)
  #   ENV['TRELLO_OAUTH_TOKEN'] = auth.credentials.token
  #   ENV['TRELLO_OAUTH_TOKEN_SECRET'] = auth.credentials.secret
  #   user
  # end

  # def self.create_from_trello auth
  #   User.create_with(
  #     trello_id: auth.info.email
  #     ).find_or_create_by(
  #     email: auth.info.email
  #   )
  # end

  # def link_github_id token
  #   client = Octokit::Client.new client_id: Rails.application.secrets['github_id'], client_secret: Rails.application.secrets['github_secret']
  #   self.github_id = client.user(email: self.email)
  # end

end
