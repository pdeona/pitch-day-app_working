class LandingController < ApplicationController
  before_action :current_user, only: :index

  def index
    if @current_user
      @projects = @current_user.projects
    end
  end

end
