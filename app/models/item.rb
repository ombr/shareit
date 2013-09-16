class Item < ActiveRecord::Base

  serialize :exifs

  mount_uploader :file, ItemUploader

  after_create :create_posts
  before_save :extract_exif

  validates :path, presence: true, uniqueness: true

  def create_posts
    current_path = Pathname.new self.path
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
    exifs = MiniExiftool.new file.current_path
    self.exifs= exifs
  end

end
