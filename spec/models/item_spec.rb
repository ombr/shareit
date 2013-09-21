require 'spec_helper'

describe Item do

  it { should have_and_belong_to_many(:posts) }

  it { should belong_to(:user) }

  describe '#create!' do
    let (:file) { File.open File.join(Rails.root, 'spec', 'fixtures', 'image.jpg') }
    let (:path) { '/2013/2013-09-26_First_post/image1.jpg' }
    let (:user) { FactoryGirl.create :user }

    subject { Item.create!( path: path, file: file, user: user) }

    it 'creates a file object' do
      subject
      Item.count.should == 1
    end

    it { subject.path.should == path }

    describe 'create some posts' do
      it 'creates on or more posts' do
        subject
        Post.count.should >= 1
      end

      it 'have the post' do
        subject.posts.count.should >=1
      end

      it 'post should have the same user' do
        subject.posts.first.user.should == subject.user
      end
    end
  end

end
