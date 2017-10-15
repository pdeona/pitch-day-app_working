module UserHelper

  def user_card user
    %Q(
      <div>
        #{image_tag user.image, size: '48x48', class: "user-card-image"}
      </div>
      <div id='user-card-name'>
        #{user.trello_id}
      </div>
    Current Projects:
      #{user.projects.count}
    ).html_safe
  end
end
