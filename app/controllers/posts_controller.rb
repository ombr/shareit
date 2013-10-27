class PostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_user
  before_filter :check_access

  def index
    @posts = @user.posts.order(started_at: :desc)
  end

  def show
    @post = @user.posts.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

end
