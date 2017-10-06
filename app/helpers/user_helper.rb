module UserHelper

  def link_github_button
    auth = request.env['omniauth.rb']
    # @current_user.link_github_id(auth)
  end

end

