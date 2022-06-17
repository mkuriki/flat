class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @post = Post.find(params[:post_id])
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
    @post = Post.find(params[:post_id])
  end

  def destroy
    @group = Group.find(params[:id])
    @group.delete
    redirect_to request.referer
  end

  def update
    if @group.update(group_params)
      @post = Post.find(params[:post_id])
      redirect_to public_post_group_path(@post, @group)
    else
      render "edit"
    end
  end

end
