require 'spec_helper'

describe Item do
  describe '#create!' do
    let (:file) { File.open File.join(Rails.root, 'spec', 'fixtures', 'image.jpg') }
    let (:path) { '/2013/2013-09-26_First_post/image1.jpg' }
    subject { Item.create!( path: path, file: file) }

    it 'creates a file object' do
      subject
      Item.count.should == 1
    end

    it { subject.path.should == path }

    it 'creates on or more posts' do
      subject
      Post.count.should >= 1
    end
  end

end
