class ItemsController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @item = @post.items.find(params[:id])
  end
end
