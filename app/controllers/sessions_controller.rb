class SessionsController < ApplicationController

  def create
    # omniauth middleware stores oauth data in the request.env instead of params
    auth = request.env["omniauth.auth"]

    # even though this is a login action, an OAuth login can be a login *or* a registration
    #
    # if the user exists, log her in
    # if the user doesn't exist, create her, then log her in
    case params['provider']
    when 'github'
      user = User.find_by(github_id: auth['uid']) || User.create_from_github(auth)
    when 'trello'
      user = User.find_by(trello_id: auth['email']) || User.create_from_trello(auth)
    end
    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in!"
  end

  def destroy
    log_out
    redirect_to root_path, :notice => 'Logged out successfully.'
  end

  private

  def log_in user
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end


