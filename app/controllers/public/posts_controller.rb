class Public::PostsController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.all
  end
  
  def create
    @new_post = Post.new(post_params)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  # 投稿データのストロングパラメータ
  private

  def post_params
    params.require(:post).permit(:post_image, :title, :body)
  end
end
