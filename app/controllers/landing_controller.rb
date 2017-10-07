class LandingController < ApplicationController
  def index
    redirect_to login_path if current_user.nil?
  end

  def github_client_auth

  end
end
