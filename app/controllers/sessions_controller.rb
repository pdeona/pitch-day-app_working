class SessionsController < ApplicationController

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
    @user = User.find(session[:user_id]) unless session[:user_id].nil?
    @user.connect_to_trello(auth)
    @user.trello_oauth = params['oauth_token']
    @user.trello_oauth_verifier = params['oauth_verifier']
    return render root_path unless @user.save
    redirect_to users_path, notice: 'Trello connected!'
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


