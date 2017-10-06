class SessionsController < ApplicationController

  def create
    # omniauth middleware stores oauth data in the request.env instead of params
    auth = request.env["omniauth.auth"]
    # even though this is a login action, an OAuth login can be a login *or* a registration
    user = User.trello_oauth_token_set(auth)
    session[:user_id] = user.id unless session[:user_id] == user.id
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


