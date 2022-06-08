class ApplicationController < ActionController::Base
  #サインアウト後の変遷先
  #管理側の場合管理用ログイン、それ以外はユーザーログインへ
  def after_sign_out_path_for(resource)
     if resource == :admin
      new_admin_session_path
     else
      new_user_session_path
     end
  end
  

end
