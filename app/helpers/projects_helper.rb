module ProjectsHelper

  def card_spans cards, list_name
    html = ""
    cards.each_pair do |card_list, cards|
      if (card_list == list_name.to_sym || card_list == list_name)
        cards.each do |card_data|
          card_data.each_pair do |key, card|
            if key == 'unassigned' || key == :unassigned
              card.each do |card|
                html << (j render partial: 'boards/card', locals: {collaborator: nil, card_name: card[0], last_active: card[1]})
              end
            else
              card.each do |card|
                html << (j render partial: 'boards/card', locals: {collaborator: card[0], card_name: card[1], last_active: card[2]})
              end
            end
          end
        end
      end
    end
    html
  end

end
