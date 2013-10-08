class Post < ActiveRecord::Base

  validates_uniqueness_of :path, allow_nil: false, scope: :user_id

  has_and_belongs_to_many :items
  belongs_to :user

  validates :user, presence: true

  def path= path
    self[:path] = path
    if self.name.blank?
      path_name = Pathname.new path
      self.name= self.class.postname(path_name.basename.to_s)
    end
  end

  def next(item)
    list = items.to_a
    list[ list.index(item) + 1 ]
  end

  class << self
    def postname(filename)
      if filename.match /(.*\/)*\d{4}[-_]+\d\d[-_]+\d\d[-_]+(.*)/
        return $2.humanize.squish
      end
      filename
    end
  end
end
