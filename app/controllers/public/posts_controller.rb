class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag_name].split(',')
    if @post.save
      @post.save_tags(tag_list)
      redirect_to public_post_path(@post.id)
      flash[:notice] = "You have created post successfully."
    else
      @posts = Post.all
      render :index
    end
  end
  
  def index
    @posts = Post.all
    @tag_list=Tag.all
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
      redirect_to public_post_path(@post), notice: "You have updated post successfully."
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to  public_posts_path
  end
  
  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @posts = @tag.posts
  end
  
  # 投稿データのストロングパラメータ
  private

  def post_params
    params.require(:post).permit(:title, :body, :post_image, tag_ids: [])
  end
end
