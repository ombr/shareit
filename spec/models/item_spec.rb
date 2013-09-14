require 'spec_helper'

describe Item do
  describe '#create!' do
    let (:file) { File.open File.join(Rails.root, 'spec', 'fixtures', 'image.jpg') }
    it 'creates a file object' do
      Item.create!(
        path: 'image.jpg',
        file: file
      )
      Item.count.should == 1
    end

    it 'creates on or more posts' do
      Item.create!(
        path: 'image.jpg',
        file: file
      )
      Post.count.should >= 1
    end
  end

end
