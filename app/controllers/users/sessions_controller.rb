class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    guest = User.guest
    sign_in guest
    redirect_to public_user_path(guest), notice: 'guestuserでログインしました。'
  end
end