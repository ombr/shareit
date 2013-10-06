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
    if post.started_at.nil? or ( started_at and post.started_at > started_at )
      post.started_at = started_at
    end

    if post.ended_at.nil? or (ended_at and post.ended_at < ended_at)
      post.ended_at = ended_at
    end

    post.items << self
    post.save!
  end

  def exifs= exifs
    self[:exifs] = exifs
    if exifs['Rating']
      self.rating= exifs['Rating']
    end
    if exifs['DateTimeOriginal']
      self.started_at= exifs['DateTimeOriginal']
      self.ended_at= exifs['DateTimeOriginal']
    end
  end

  def extract_exif
    exifs = MiniExiftool.new file.current_path
    self.exifs= exifs.to_hash
  end

end
