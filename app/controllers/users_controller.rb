class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])
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

end
