class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
  end

  def create
    #Post.create(description: params[:description], user_id: current_user.id)
    #@post = Post.create(description: post_params, user_id: current_user.id)
    @post = current_user.posts.create(post_params)
    redirect_to user_path(current_user)
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
  end

  def update
    Post.find(params[:id]).update(params.require(:post).permit(:description))
    redirect_to user_path(current_user)
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to user_path(current_user)
  end

  private

  def post_params
  params.require(:post).permit(:description, :image)
  end

end
