class MakeTrelloBoardJob < ApplicationJob
  queue_as :new_board

  def perform(user_oauth, user_secret, project)
    @client = Trello::Client.new(
      consumer_key: Rails.application.secrets['trello_key'],
      consumer_secret: Rails.application.secrets['trello_secret'],
      oauth_token: user_oauth,
      oauth_secret: user_secret)
    board = @client.create(:board, {name: project.name})
    new_board = Board.new(
            name: project.name,
            project_id: project.id,
            trello_id: board.id,
            url: board.url)
    new_board.create_labels board, @client
    new_board.create_lists board, @client
    new_board.create_cards board, @client
    if new_board.save!
      project.board = new_board
      project.save!
    end
  end
end
