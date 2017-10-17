class LandingController < ApplicationController
  before_action :current_user, only: :index

  def index
    if @current_user
      @projects = @current_user.projects
      render 'projects/dashboard_blank' if @projects.empty?
    else
      redirect_to landing_new_user_path
    end
  end

  def new_user

  end

end
