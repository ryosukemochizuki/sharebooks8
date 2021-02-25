class ActionpostsController < ApplicationController
  before_action :logged_in_user?
  before_action :correct_user?

  def index
    @actionposts = current_user.actionposts
  end

  def show
    @actionpost = current_user.actionposts.find(params[:id])
  end

  def create
    @actionpost = current_user.actionposts.build(actionpost_params)
    if @actionpost.save
      flash[:success] = "your new action is successfully added!"
      redirect_to actionpost_path(@actionpost)
    else
      render 'static_pages/home'
    end
  end

  def edit
    @actionpost = current_user.actionposts.find(params[:id])
  end

  def update
    @actionpost = current_user.actionposts.find(params[:id])
    if @actionpost.update(actionpost_params)
      flash[:success] = "your new action is successfully added!"
      redirect_to actionpost_path(@actionpost)
    else
      render 'edit'
    end
  end

  def destroy
    @actionpost.destroy
    flash[:success] = "The action was deleted."
    redirect_to root_url
  end

  private

  def actionpost_params
    params.require(:actionpost).permit(:title, :highlight, :action)
  end

  # 正しいユーザーしか削除できない(そのユーザーが投稿を保持しているなら)
  def correct_user?
    @actionpost = current_user.actionposts.find_by(id: params[:id])
    if @actionpost.nil?
      flash[:danger] = "your access is not permitted, try again!"
      redirect_to root_url
    end
  end
end
