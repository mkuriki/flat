class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @post = Post.find(params[:post_id])
    @group = Group.new
  end

  def create
    @post = Post.find(params[:post_id])
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.post_id = @post.id
    if @group.save
      redirect_to public_post_group_path(@post, @group), notice: "グループが作成されました"
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:post_id])
    @group = Group.find(params[:id])
  end

  def edit
    @post = Post.find(params[:post_id])
    @group = Group.find(params[:id])
    @group.owner_id = current_user.id
  end

  def update
    if @group.update(group_params)
      @post = Post.find(params[:post_id])
      redirect_to public_post_group_path(@post, @group), notice: "グループが更新されました"
    else
      @post = Post.find(params[:post_id])
      render "edit"
    end
  end

  def all_destroy
    @post = Post.find(params[:post_id])
    @group = Group.find(params[:group_id])
    if @group.destroy
    redirect_to public_post_path(@post)
    end
  end

  private

  #グループ作成のストロングパラメータ
  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end
  #ユーザーがグループ作成者かどうかの判定
  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to root_path
    end
  end
end

