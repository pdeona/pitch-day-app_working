class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  helper_method :current_user, :require_login

  def current_user
    @current_user ||=
      User.find_by id: session[:user_id]
  end

  def logged_in?
    !!(@current_user)
  end

  def require_login
    redirect_to login_path if not logged_in?
  end

end
