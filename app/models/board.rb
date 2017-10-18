class Board < ApplicationRecord
  belongs_to :project


  def add_collaborators user, collaborators
    @client = Trello::Client.new(
      consumer_key: Rails.application.secrets['trello_key'],
      consumer_secret: Rails.application.secrets['trello_secret'],
      oauth_token: user.trello_oauth,
      oauth_secret: user.trello_member_secret)
    board = @client.find(:board, self.trello_id)
    collaborators.each do |collaborator|
      trello_member = @client.find(:member, collaborator.trello_id)
      board.add_member(trello_member)
    end
  end

  def link_existing_board user, board_name
    @client = Trello::Client.new(
      consumer_key: Rails.application.secrets['trello_key'],
      consumer_secret: Rails.application.secrets['trello_secret'],
      oauth_token: user.trello_oauth,
      oauth_secret: user.trello_member_secret)
    member = @client.find(:member, user.trello_id)
    board = member.boards.collect{ |board| board if board.name == board_name['trello_name'] }.compact.first
    self.trello_id = board.id
    self.url = board.url
    card_status = {inpr:[], blocked:[]}
    ['Blocked', 'In Progress'].each do |list_name|
      if list_name == 'Blocked'
        card_status[:blocked] << (b.check_card_status user, list_name)
      else
        card_status[:inpr] << (b.check_card_status user, list_name)
      end
    end
    self.card_status = card_status.to_json
    self.save
    self
  end

  def check_card_status user, list_name
    @client = Trello::Client.new(
        consumer_key: Rails.application.secrets['trello_key'],
        consumer_secret: Rails.application.secrets['trello_secret'],
        oauth_token: user.trello_oauth,
        oauth_secret: user.trello_member_secret)
    board = @client.find(:board, self.trello_id)
    list_id = board.lists.collect { |list| list.id if list.name == list_name }.join
    list = @client.find(:list, list_id)
    cards = list.cards
    card_status = {unassigned: [], working: []}
    cards.each do |card|
      if card.member_ids.empty?
        card_status[:unassigned] << [card.name, card.last_activity_date]
      else
        card.member_ids.each do |member|
          card_status[:working] << [(@client.find(:member, member)).username, card.name, card.last_activity_date]
        end
      end
    end
    card_status
  end

  def add_to_trello user, project
    create_trello_board(user, project)
  end

  def create_trello_board user, project
    MakeTrelloBoardJob.new(
      user,
      project
      ).enqueue
  end

  def check_cards_job user
    CheckBoardCardsJob.new(
        user, self
      ).enqueue
  end

  def create_labels trello_board, client
    # Create rails-specific labels to aid in project management
    trello_board.labels.each do |label|
      label.delete
    end
    label_names =  \
          ['Model', 'Controller', 'View', 'Design', 'Project Management']
    label_colors = ['red', 'blue', 'yellow', 'purple', 'green']
    label_names.each_with_index do |label_name, i|
      client.create(:label, name: label_name, board_id: trello_board.id, color: label_colors[i])
    end
    trello_board.labels
  end

  def create_lists trello_board, client
    # Delete the standard Trello lists and replace them with our own
    list_names = ['To Do', 'In Progress', 'Blocked', 'Done']
    trello_board.lists.each do |list|
      list.close!
    end
    list_names.each_with_index do |list_name, i|
      client.create(:list, name: list_name, board_id: trello_board.id, pos: i)
    end
  end

  def create_cards trello_board, client
    # Prepare some cards to guide users on next steps
    todo_list_id = trello_board.lists.collect { |list| list.id if list.name == 'To Do' }.join
    pm_label_id = trello_board.labels.collect { |label| label.id if label.name == 'Project Management' }.join
    model_label_id = trello_board.labels.collect { |label| label.id if label.name == 'Model' }.join
    template_card_data = [
          {
            name: "Create ERD to represent your Application's Data Flow",
            list_id: todo_list_id,
            desc: %Q(An Entity Relationship Diagram is crucial to \
                planning out your workflow. It will inform important decisions about \
                the flow of data through your application and help you plan what data \
                you want to store, how to store it, and how it will relate to other data \
                your application collects.),
            card_labels: model_label_id
          },
          {
            name: 'Set Up Project Template for Technical Meeting',
            list_id: todo_list_id,
            desc: %Q(The Project Template can be found in your Google Drive. \
                It contains important information regarding the requirements \
                for Pitch Day and some guidelines for when you should plan on \
                being finished. Be sure to have it done before your technical \
                meeting so you can review your plans.),
            card_labels: pm_label_id
          },
          {
            name: 'Add your Group Members to this Trello Board and your Github Repo',
            list_id: todo_list_id,
            desc: %Q(You can't go it alone! Be sure to add your group members to this Trello Board \
                and add them as collaborators to your Github Repo. To add Trello users to a Board, click \
                the 'Show Menu...' button in the top right corner, and type your group members' \
                Trello usernames into the Invite box!
                On Github, you can add collaborators to a repository by clicking on Settings from your repo's main page. \
                The Collaborators button can be found on the left. It may ask you to input your password. Once you reach \
                the Collaborators screen you can add each group member with their Github username, and they will receive \
                an email with a link allowing them to join!
                If only working with a team could always be this easy!),
            card_labels: pm_label_id
          },
          {
            name: 'Divide and Conquer!',
            list_id: todo_list_id,
            desc: %Q(You and your team have the ultimate advantage: each other. \
                Make use of it! Don't waste time working on redundant tasks, \
                support members who are blocked, and most importantly, \
                COMMUNICATE!
                Use the Trello Board to identify member's strengths, let them \
                know they're doing a good job, ask what's going on when they're stuck \
                on one card for a long time. A cohesive team is working on many different \
                tasks, as one unit. ),
            card_labels: pm_label_id
          },
          {
            name: 'Create the rest of your Trello cards',
            list_id: todo_list_id,
            desc: %Q(Trello is an amazing tool. The biggest problem most projects have with using it, \
                is not using it! Start building out this list with all your goals for your project, \
                and keep your User Story and your ERD in mind when you do. Keep in mind these handy \
                color-coded labels we've created, allowing you to categorize your tasks. If these aren't enough, \
                make more!
                Make sure everyone on the team is active on Trello. The Board will keep everyone \
                on the same page and save time communicating and coordinating group efforts. Make sure pay attention \
                when you see a team member move their card to the Blocked List - something's up!
                Make sure your team stays on the same page by meeting regularly, either in person or via \
                Slack. Reference the Trello Board in meetings and review the activity since the previous meeting.
                Before you know it, you'll be conducting your Retro and getting ready to present!),
            card_labels: pm_label_id
          }
        ]
    cards = template_card_data
    cards.each do |card|
      client.create(:card, card)
    end
  end


end

