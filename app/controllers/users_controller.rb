class UsersController < ApplicationController

  before_action :current_user, only: [:show, :destroy]

  def show
    if @current_user
      @user = User.find(@current_user.id)
    else
      redirect_to login_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:trello_id, :slack_id)
  end

end
