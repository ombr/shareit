class ItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_user
  before_filter :require_post
  before_filter :require_item
  before_filter :check_access

  def show
    @next = @post.next(@item)
    @previous = @post.previous(@item)
  end
  private

    def require_item
      @item = @post.items.find(params[:id])
    end
end
