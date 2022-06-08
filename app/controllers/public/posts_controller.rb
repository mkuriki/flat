class Public::PostsController < ApplicationController
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    
    if @post.save
      redirect_to public_post_path(@post.id)
      flash[:notice] = "You have created book successfully."
    else
      @posts = Post.all
      render :index
    end
  end
  
  def index
    @post = Post.new
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
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
    params.require(:post).permit(:title, :body)
  end
end
