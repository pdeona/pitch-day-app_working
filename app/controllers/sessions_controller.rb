class SessionsController < ApplicationController

  before_action :current_user

  def create
    # omniauth middleware stores oauth data in the request.env instead of params
    auth = request.env['omniauth.auth']

    # even though this is a login action, an OAuth login can be a login *or* a registration
    #
    # if the user exists, log her in
    # if the user doesn't exist, create her, then log her in
    user = User.find_by(github_id: auth.info['nickname']) || User.create_from_github(auth.info)
    user.github_oauth = auth.credentials.token
    session[:user_id] = user.id if user.save
    redirect_to root_url, notice: "Signed in!"
  end

  def destroy
    log_out
    redirect_to root_path, :notice => 'Logged out successfully.'
  end

  def trello_callback
    auth = request.env['omniauth.auth']
    @current_user.connect_to_trello(auth)
    oauth_token = auth.extra.access_token
    @current_user.trello_member_token = params['oauth_token']
    @current_user.trello_member_secret = params['oauth_verifier']
    @current_user.trello_oauth = oauth_token.token
    @current_user.trello_oauth_verifier = oauth_token.secret
    return render root_path unless @current_user.save
    redirect_to user_path, notice: 'Trello connected!'
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
