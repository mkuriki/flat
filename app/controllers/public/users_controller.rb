class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:show_withdraw, :withdraw, :edit, :update]
  before_action :ensure_guest_user, only: [:edit]


  def show
    @user = User.find(params[:id])
    @myfavorites = Favorite.where(user_id: current_user.id)
    @myposts = Post.where(user_id: current_user.id).page(params[:page])
    @mygroups = GroupUser.where(user_id: current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to public_user_path(@user), notice: "プロフィールが更新されました"
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
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to public_user_path(current_user)
    end
  end
  #ゲストユーザーの編集規制（trueの場合編集画面へ遷移できない）
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end


