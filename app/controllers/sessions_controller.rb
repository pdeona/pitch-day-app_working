class SessionsController < ApplicationController

  def create
    user = User.find_by(trello_id: session_trello_id)
    if user
      log_in user
      redirect_to user_path(user), :notice => "Logged in successfully."
    else
      flash.now[:danger] = "Invalid email/password combination."
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path, :notice => 'Logged out successfully.'
  end

  private

  def session_params
    params.require(:session).permit(:trello_id)
  end

  def log_in user
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
