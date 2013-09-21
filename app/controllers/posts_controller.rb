class PostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_user
  before_filter :check_access

  def index
    @posts = @user.posts
  end

  private

    def require_user
      @user = User.find(params[:user_id])
    end

    def check_access
      if current_user != @user
        return redirect_to user_id: current_user
      end
    end
end
