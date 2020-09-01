class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    User.find(params[:id]).update(user_params)
    redirect_to user_path(current_user)
  end

  def create
    User.create(user_params)
    redirect_to user_path(current_user)
  end

  # 自分がフォローしているユーザー一覧
  def following
    @user = User.find(params[:user_id])
    @followings = @user.following_user.where.not(id: @user.id)
  end

  # 自分をフォローしているユーザー一覧
  def followers
    @user = User.find(params[:user_id])
    @followers= @user.follower_user.where.not(id: @user.id)
  end

  private
  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:name, :image, :profile)
  end

end
