class WelcomeController < ApplicationController

  def index
    redirect_to user_path(id: current_user) if current_user
  end
end
