class SessionsController < ApplicationController

  def new
    
  end

  def create
    @user = User.find_by(account_id: params[:session][:account_id])
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      flash[:success] = "you logged in successfully!"
      redirect_to user_url(current_user)
    else
      # renderによるflashメッセージの制限
      flash.now[:danger] = "Email or Password is invalid! Try again!"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
  
end
