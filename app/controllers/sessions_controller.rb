class SessionsController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    user = User.find_by_provider_and_uid(auth['provider'], auth['uid']) ||
      User.create_with_omniauth(auth)
    login(user)
    redirect_to root_path
  end

  def destroy
    logout
    redirect_to root_path
  end
end