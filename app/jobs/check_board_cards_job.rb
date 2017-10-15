class CheckBoardCardsJob < ApplicationJob
  queue_as :check_cards

  def perform(user, board)
    lists = ['In Progress', 'To Do', 'Blocked', 'Done']
    cards_status = {}
    lists.each do |list|
      cards_status[:"#{list}"] = board.check_card_status user, list
    end
    cards_status
  end
end
