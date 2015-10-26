class UsersController < ApplicationController

  before_action :require_signed_in, only: [:show, :index]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    redirect_to user_goals_url(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:session_token] = @user.session_token
      redirect_to users_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
