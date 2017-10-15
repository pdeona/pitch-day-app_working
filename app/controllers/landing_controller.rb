class LandingController < ApplicationController
  before_action :current_user, only: :index

  def index
  end

end
