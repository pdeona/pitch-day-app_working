module UserHelper

  def user_card user
    %Q(
      <div id='user-card-image'>
        #{image_tag user.image, size: '48x48'}
      </div>
      <div id='user-card-name'>
        #{user.trello_id}
      </div>
    Current Projects:
      #{user.projects.count}
    ).html_safe
  end
end
