class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i(show edit update destroy)

  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(30)
    @user = current_user
    @posts = Post.all.order(created_at: 'DESC').page(params[:page]).per(30)
    @q = Post.ransack(params[:q])
    @search_posts = @q.result(distinct: true).order(created_at: :desc)
  end

  def show
    @user = User.find_by(id: @post.user_id)
    @comment = Comment.new
    @comments = @post.comments
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to user_path(current_user)
    else
      render action: :new
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @user = User.find_by(id: @post.user_id)
  end

  def update
    @user = User.find_by(id: @post.user_id)
    if @post.update(post_params)
      redirect_to user_path(current_user)
      flash[:notice] = "投稿を編集しました"
    else
      render "posts/edit"
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "投稿を削除しました。"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "投稿を削除できませんでした。"
      render action: :edit
    end
  end

  def timeline
    @posts = Post.where(user: current_user.following_user)
    @likes = Like.where(post: @posts)
    @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

  private

  def post_params
    params.require(:post).permit(:description, :image, :amount, :alcohol, category_ids: [] )
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
