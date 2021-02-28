class Admin::UsersController < ApplicationController
  before_action :logged_in_user?
  before_action :admin_user?

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy
      flash[:success] = "Account deleted"
      redirect_to admin_users_url
    end
  end

  private

  def admin_user?
    unless current_user.admin?
      flash[:danger] = "this access is invalid."
      redirect_to root_url
    end
  end
end
