class UsersController < ApplicationController

  before_action :current_user, only: [:show, :destroy]

  def show

    # unless @current_user
    #   redirect_to login_path
    # else
    #   @user = @current_user
    # end
  end

  def new
    @user = User.new
  end

  def create

  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:trello_id, :github_id, :email, :slack_id)
  end

end
