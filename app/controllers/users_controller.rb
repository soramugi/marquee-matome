class UsersController < ApplicationController
  before_action :require_user

  def show
  end

  private
  def require_user
    @user = User.find_by(name: params[:name])
  end
end
