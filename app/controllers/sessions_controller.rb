class SessionsController < ApplicationController

  before_action :current_user

  def create
    # omniauth middleware stores oauth data in the request.env instead of params
    auth = request.env['omniauth.auth']

    # even though this is a login action, an OAuth login can be a login *or* a registration
    #
    # if the user exists, log her in
    # if the user doesn't exist, create her, then log her in
    user = User.find_by(github_id: auth.info['nickname'])
    if user
      user.github_oauth = auth.credentials.token
      session[:user_id] = user.id if user.save
      redirect_to root_path, notice: "Signed in!"
    else
      user = User.create_from_github(auth.info)
      user.github_oauth = auth.credentials.token
      session[:new_user_id] = user.id
      redirect_to users_step_two_path
    end
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
