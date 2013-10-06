require 'spec_helper'

describe Item do

  it { should have_and_belong_to_many(:posts) }

  it { should belong_to(:user) }

  let (:file) { File.open File.join(Rails.root, 'spec', 'fixtures', 'image.jpg') }
  let (:path) { '/2013/2013-09-26_First_post/image1.jpg' }
  let (:user) { FactoryGirl.create :user }
  subject { Item.create!( path: path, file: file, user: user) }

  describe '#create!' do
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

    #it { should validate_uniqueness_of(:path).scoped_to(:user_id) }
    describe 'validate_uniqueness_of path' do
      let (:file2) { File.open File.join(Rails.root, 'spec', 'fixtures', 'image.jpg') }
      let (:path2) { '/2013/2013-09-26_First_post/image2.jpg' }
      let (:user2) { FactoryGirl.create :user }
      it 'raise an exception' do
        expect {
        subject
          Item.create!(path: path, file: file2, user: user)
        }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'Can create a second item' do
        subject
        Item.create!(path: path2, file: file, user: user)
      end

      it 'another user can create an item with the same path' do
        subject
        Item.create!(path: path, file: file, user: user2)
      end
    end

    describe 'extract exifs' do
      let (:file) { File.open File.join(Rails.root, 'spec', 'fixtures', 'canon-ixus.jpg') }
      it 'extract and store the exifs' do
        subject.exifs["DateTimeOriginal"].should == "2001-06-09 15:17:32 +0200"
      end

      describe 'date' do
        it 'extract started_at' do
          subject.started_at.should == "2001-06-09 15:17:32 +0200"
        end

        it 'extract ended_at' do
          subject.ended_at.should == "2001-06-09 15:17:32 +0200"
        end

        it 'create a post with the right date' do
          subject.posts.first.started_at.should == "2001-06-09 15:17:32 +0200"
        end

        it 'create a post with the right date' do
          subject.posts.first.ended_at.should == "2001-06-09 15:17:32 +0200"
        end
      end

      describe 'rating' do
        let (:file) { File.open File.join(Rails.root, 'spec', 'fixtures', 'image.jpg') }
        it 'extract the rating' do
          subject.rating.should == 5
        end
      end
    end
  end

end
