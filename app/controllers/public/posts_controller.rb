class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    before_uniq_tag_list = params[:post][:tag_name].split(' ')
    after_uniq_tag_list = params[:post][:tag_name].split(' ').uniq
    if before_uniq_tag_list.size == after_uniq_tag_list.size
      tag_list =  before_uniq_tag_list
    else
      tag_list = after_uniq_tag_list
    end
    if @post.save
      @post.save_tags(tag_list)
      redirect_to public_post_path(@post.id), notice: "投稿が作成されました"
    else
      @posts = Post.page(params[:page])
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page])
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @groups = Group.where(post_id: @post.id)
  end

  def edit
    @post = Post.find(params[:id])
    @tag = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    @tag_list=params[:post][:name].split(',')
    if  @post.update(post_params)
      @old_relations = PostTag.where(post_id: @post.id)
      @old_relations.each do |relation|
        relation.delete
      end
      @post.save_tags(@tag_list)
      redirect_to public_post_path(@post), notice: "投稿が更新されました"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to  public_posts_path
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts
  end

  private

  # 投稿データのストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :body, :post_image)
  end
   # 特定のユーザーとログインユーザーの一致を確認
  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to public_posts_path
    end
  end
end
