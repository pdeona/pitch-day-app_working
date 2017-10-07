class Board < ApplicationRecord
  belongs_to :project

  validates :trello_id, presence: true

  def make_new_board id
    @trello_client = Trello::Client.new(
                        consumer_key: User.find(id).trello_member_token,
                        consumer_secret: User.find(id).trello_member_secret,
                        oauth_token: User.find(id).trello_oauth,
                        oauth_secret: User.find(id).trello_oauth_verifier)
  end
end
