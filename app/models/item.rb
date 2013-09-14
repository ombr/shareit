class Item < ActiveRecord::Base

  attr_accessor :path

  mount_uploader :file, ItemUploader

  after_create :create_posts

  def create_posts
    current_path = Pathname.new @path
    post = Post.find_or_create_by!(path: current_path.parent.to_s)
    post.items << self
    post.save!
  end
end
