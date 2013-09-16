class Post < ActiveRecord::Base

  validates :path, presence: true, uniqueness: true

  has_and_belongs_to_many :items

  def path= path
    self[:path] = path
    if self.name.blank?
      path_name = Pathname.new path
      self.name= self.class.postname(path_name.basename.to_s)
    end
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
