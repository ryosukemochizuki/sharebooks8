class SessionsController < ApplicationController

  def new
    
  end

  def create
    user = User.find_by(account_id: params[:session][:account_id])
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = "you logged in successfully!"
      redirect_to user_url(current_user)
    else
      # renderによるflashメッセージの制限
      flash.now[:danger] = "Account ID or Password is invalid! Try again!"
      render 'new'
    end
  end

  def destroy
    if user_logged_in?
      log_out(current_user)
      flash[:success] = "you logged out successfully!"
      redirect_to root_url
    else
      flash[:success] = "you already logged out!"
      redirect_to root_url
    end
    # log_out(current_user) if user_logged_in?
    # flash[:success] = "you logged out successfully!"
    # redirect_to root_url
  end
  
end
