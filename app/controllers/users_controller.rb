class UsersController < ApplicationController

  def step_two
    redirect_to '/auth/trello'
  end

  def trello_callback
    auth = request.env['omniauth.auth']
    @current_user = User.find session[:new_user_id]
    @current_user.connect_to_trello(auth)
    oauth_token = auth.extra.access_token
    @current_user.trello_member_token = params['oauth_token']
    @current_user.trello_member_secret = params['oauth_verifier']
    @current_user.trello_oauth = oauth_token.token
    @current_user.trello_oauth_verifier = oauth_token.secret
    return render root_path unless @current_user.save
    session[:user_id] = session[:new_user_id]
    redirect_to root_path, notice: 'Trello connected!'
  end

  def search
    term = params[:term]
    respond_to do |format|
      format.json { @users = User.search(term) }
    end
  end

  private

  def user_params
    params.require(:user).permit(:trello_id, :github_id, :email, :slack_id)
  end

end
