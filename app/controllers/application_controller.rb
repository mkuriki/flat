class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
  #サインアウト後の変遷先
  #管理側の場合管理用ログイン、それ以外はユーザーログインへ
  def after_sign_out_path_for(resource)
     if resource == :admin
      new_admin_session_path
     else
      new_user_session_path
     end
  end
  
  def after_sign_in_path_for(resource)
     if resource == :admin
      admin_users_path
     else
      root_path
     end
end
  
end
