class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all.order(created_at: 'DESC').page(params[:page]).per(30)
    @q = Post.ransack(params[:q])
    @search_posts = @q.result(distinct: true).order(created_at: 'DESC')
  end

  def show
    @post = Post.find_by(id: params[:id])
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
      flash[:alert] = "投稿できませんでした。"
      render action: :new
    end
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
    if @post.destroy
      flash[:notice] = "投稿を削除しました。"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "投稿を削除できませんでした。"
      render action: :edit
    end
  end

  def timeline
    @posts = Post.where(user_id: current_user.following_user.ids)
    @likes = Like.where(post_id: @posts.ids)
  end

  private

  def post_params
  params.require(:post).permit(:description, :image, category_ids: [])
  end

end
