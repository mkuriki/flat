class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @groups = Group.where(post_id: @post.id)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: "投稿を更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

  # 投稿データのストロングパラメータ
  private

  def post_params
    params.require(:post).permit(:title, :body, :post_image)
  end
end

