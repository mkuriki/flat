class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update, :edit]
  before_action :correct_user, only: [:withdraw, :edit, :update]
  
  
  def show
    @user = User.find(params[:id])
    @favorites = Favorite.where(user_id: current_user.id)
    @groups = GroupUser.where(user_id: current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      redirect_to public_user_path(@user)
      flash[:notice] = "User was successfully updated."
    else
      render :edit
    end
  end
  
  def show_withdraw
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    if @user.is_deleted = true
      @user.save!
      reset_session
      redirect_to root_path
    end
  end
  
  private
  
  # ユーザーデータのストロングパラメータ
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  # 特定のユーザーとログインユーザーの一致を確認
  def correct_user
  @user = User.find(params[:id])
  redirect_to(public_user_path(current_user)) unless @user == current_user
  end
  
end
