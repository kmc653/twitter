class UsersController < ApplicationController
  before_action :require_user, only: [:follow, :unfollow]

  def index
    @users = User.all 
  end

  def show
    @user = User.find_by username: params[:username]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You have registered!"
      redirect_to user_path(@user.username)
    else
      render :new
    end
  end

  def follow
    user = User.find(params[:id])
    if user
      current_user.following_users << user
      flash[:notice] = "You're now following #{user.username}"
      redirect_to user_path(user.username)
    else
      wrong_path
    end
  end

  def unfollow
    user = User.find(params[:id])
    rel = Relationship.where(follower: current_user, leader: user).first
    if user
      rel.destroy
      flash[:notice] = "You're no longer folllowing #{user.username}"
      redirect_to user_path(user.username)
    else
      wrong_path
    end
  end

  def timeline
    @statuses = []
    current_user.following_users.each do |user|
      @statuses << user.statuses
    end
    @statuses.flatten!
  end

  private
  
  def user_params
    params.require(:user).permit!
  end
end