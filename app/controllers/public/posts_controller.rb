class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
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
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @groups = Group.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to  public_posts_path
  end
  
  # 投稿データのストロングパラメータ
  private

  def post_params
    params.require(:post).permit(:title, :body, :post_image)
  end
end
