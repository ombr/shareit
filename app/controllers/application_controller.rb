class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private

    def require_user
      @user = User.find(params[:user_id])
    end

    def require_post
      @post = @user.posts.find(params[:post_id])
    end

    def check_access
      if current_user != @user
        return redirect_to user_path(id: current_user)
      end
    end
end
