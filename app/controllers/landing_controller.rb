class LandingController < ApplicationController
  before_action :current_user

  def index
    unless @current_user
      redirect_to login_path
    end
  end

end
