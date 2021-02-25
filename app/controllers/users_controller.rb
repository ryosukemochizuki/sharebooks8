class UsersController < ApplicationController
  before_action :logged_in_user?, except: [:new, :create]
  before_action :correct_user?, except: [:new, :create]
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "you signed up successfully!"
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "your profile updated successfully!"
      redirect_to user_url(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:account_id, :username, :email, :password, :password_confirmation)    
  end

  # 正しいユーザーしかアクセスできない(今のユーザーがcurrent_userか)
  def correct_user?
    user = User.find(params[:id])
    if !(user == current_user)
      flash[:danger] = "this access is invalid."
      redirect_to root_url
    end
  end
end
