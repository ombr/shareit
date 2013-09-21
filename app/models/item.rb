class Item < ActiveRecord::Base

  serialize :exifs

  belongs_to :user
  has_and_belongs_to_many :posts

  mount_uploader :file, ItemUploader

  after_create :create_posts
  before_save :extract_exif

  validates_uniqueness_of :path, allow_nil: false, scope: :user
  validates :user, presence: true

  def create_posts
    current_path = Pathname.new self.path
    post = Post.find_or_create_by!(path: current_path.parent.to_s, user: user)
    post.items << self
    post.save!
  end

  def exifs= exifs
    self[:exifs] = exifs
    if exifs[:rating]
      self.rating= exifs[:rating]
    end
  end

  def extract_exif
    exifs = MiniExiftool.new file.current_path
    self.exifs= exifs.to_hash
  end

end
