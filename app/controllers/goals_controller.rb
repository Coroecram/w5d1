class GoalsController < ApplicationController

  before_action :require_signed_in
  before_action :goal_owner?, only: [:edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    if @user == current_user
      @goals = @user.goals
    else
      @goals = @user.public_goals
    end
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id

    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
    if @goal.user == current_user
      render :show
    elsif @goal.private == false
      render :show
    else
      flash[:errors] = "Private Goal"
      redirect_to user_url(current_user)
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_goals_url(current_user)
  end

  private
  def goal_params
    params.require(:goal).permit(:name, :description, :private, :completed)
  end

  def goal_owner?
    @goal = Goal.find(params[:id])
    redirect_to user_url(current_user) unless current_user.id == @goal.user_id
  end
end
