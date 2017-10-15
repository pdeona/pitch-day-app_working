module ProjectsHelper

  def card_div list_name
    html = ""
    @cards_status.each_pair do |card_list, cards|
      if card_list == list_name
        cards.each do |card_data|
          card_data.each_pair do |key, card|
            if key == :working
              card.each do |card|
                html += (j render partial: 'boards/card', locals: {collaborator: card[0], card_name: card[1]})
              end
            else
              card.each do |card|
                html += (j render partial: 'boards/card', locals: {collaborator: nil, card_name: card})
              end
            end
          end
        end
      end
    end
    html
  end

end
