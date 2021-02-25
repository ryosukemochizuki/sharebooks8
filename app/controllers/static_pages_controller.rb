class StaticPagesController < ApplicationController
  def home
    @actionpost = current_user.actionposts.build if user_logged_in?
  end

  def about
  end

  def contact
  end
end
