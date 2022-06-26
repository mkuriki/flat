class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @group = Group.find(params[:id])
    @post = Post.find(params[:post_id])
  end

  def edit
    @group = Group.find(params[:id])
    @post = Post.find(params[:post_id])
  end

  def update
      @group = Group.find(params[:id])
    if @group.update(group_params)
      @post = Post.find(params[:post_id])
      redirect_to admin_post_group_path(@post, @group), notice: "グループが更新されました"
    else
      @post = Post.find(params[:post_id])
      render "edit"
    end
  end
  
  def all_destroy
    @post = Post.find(params[:post_id])
    @group = Group.find(params[:group_id])
    if @group.destroy
    redirect_to admin_post_path(@post)
    end
  end
  
  private
  
  #グループ更新のストロングパラメータ
  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

end
