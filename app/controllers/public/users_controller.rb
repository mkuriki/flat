class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
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

  def withdraw
    @user = user.find(params[:id])
    if @user.is_deleted = true
      @user.save!
      reset_session
      redirect_to root_path
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
