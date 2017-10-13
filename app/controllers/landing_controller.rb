class LandingController < ApplicationController
  before_action :current_user, only: :graph
  def index

  end


end
