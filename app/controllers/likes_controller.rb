class LikesController < ApplicationController
  before_action :set_post, only: %i(index create destroy)

  def index
    @likes = Like.where(post: @post)
    @user = User.find_by(id: @post.user_id)
  end

  def show
    @user = User.find(params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def create
    current_user.likes.create(post_id: params[:post_id])
  end

  def destroy
    current_user.likes.find_by(post_id: params[:post_id]).destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
