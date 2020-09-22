class LikesController < ApplicationController

  def index
    @post = Post.find(params[:post_id])
    @likes = Like.where(post_id: @post.id)
    @user = User.find_by(id: @post.user_id)
  end

  def show
    @user = User.find(params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def create
    @post = Post.find(params[:post_id])
    Like.create(user_id: current_user.id, post_id: params[:post_id])
  end

  def destroy
    @post = Post.find(params[:post_id])
    Like.find_by(user_id: current_user.id, post_id: params[:post_id]).destroy
  end

end
