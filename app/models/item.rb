class Item < ActiveRecord::Base

  serialize :exifs

  attr_accessor :path

  mount_uploader :file, ItemUploader

  after_create :create_posts
  before_save :extract_exif

  def create_posts
    current_path = Pathname.new @path
    post = Post.find_or_create_by!(path: current_path.parent.to_s)
    post.items << self
    post.save!
  end

  def exifs= exifs
    self[:exifs] = exifs
    if exifs.rating
      self.rating= exifs.rating
    end
  end

  def extract_exif
    exifs = MiniExiftool.new file.path
    self.exifs= exifs
  end

end
