class ApplicationController < ActionController::Base
  include SessionsHelper

  def logged_in_user?
    if !user_logged_in?
      flash[:danger] = "your access is not right, Please log in!"
      redirect_to login_path
    end
  end
end
