class WelcomeController < ApplicationController

  def index
    redirect_to user_posts_path(user_id: current_user) if current_user
  end
end
