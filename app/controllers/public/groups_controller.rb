class Public::GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to public_group_path(@group)
      flash[:notice] = "You have created group successfully."
    else
      render  :new
    end
  end
  
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end
  
  def edit
    @group = Group.find(params[:id])
    @group.owner_id = current_user.id
  end

  def destroy
    @group = Group.find(params[:id])
    @group.users.delete(current_user)
    redirect_to public_post_path
  end

  def update
    if @group.update(group_params)
      redirect_to :show
    else
      render "edit"
    end
  end
  
  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image) 
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to root_path
    end
  end
end

