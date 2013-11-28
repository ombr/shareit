# encoding: utf-8
require 'spec_helper'

describe Post do

  it { should belong_to(:user) }
  it { should have_and_belong_to_many(:items) }
  it { should validate_uniqueness_of(:path).scoped_to(:user_id) }


  let(:user) { FactoryGirl.create :user }
  let (:file1) { File.open(File.join(Rails.root, 'spec', 'fixtures', 'fujifilm-mx1700.jpg')) }
  let (:file2) { File.open(File.join(Rails.root, 'spec', 'fixtures', 'fujifilm-dx10.jpg')) }
  let (:file3) { File.open(File.join(Rails.root, 'spec', 'fixtures', 'canon-ixus.jpg')) }
  
  # The next items are ordered by creation dates (Exifs) :
  let (:item1) { FactoryGirl.create(:item, file: file1, path: 'test1.jpg', user: user) }
  let (:item2) { FactoryGirl.create(:item, file: file2, path: 'test2.jpg', user: user) }
  let (:item3) { FactoryGirl.create(:item, file: file3, path: 'test3.jpg', user: user) }

  describe '#path=' do
    context 'whithout a name' do
      subject { Post.new }
      it 'sets the name' do
        subject.path = 'test/lalala'
        subject.name.should == 'lalala'
      end
    end
    context 'with a name' do
      subject { Post.new name: 'My Name'}
      it 'does not set the name' do
        subject.path = 'test/lalala'
        subject.name.should == 'My Name'
      end
    end
  end

  describe 'dates' do
    describe 'started_at' do
      it 'returns the right date' do
        item1
        item2
        item1.posts.first.started_at.should == item1.started_at
      end

      it 'returns the right date' do
        item2
        item1
        item1.posts.first.started_at.should == item1.started_at
      end
    end

    describe 'ended_at' do
      it 'returns the right date' do
        item1
        item2
        item1.posts.first.ended_at.should == item2.ended_at
      end

      it 'returns the right date' do
        item2
        item1
        item1.posts.first.ended_at.should == item2.ended_at
      end
    end
  end
  describe 'item' do
    before :each do
      item1
      item2
      item3
    end
    subject{ item1.posts.first }

    it { subject.next(item1).should == item2 }
    it { subject.next(item2).should == item3 }
    it { subject.next(item3).should == nil }

    it { subject.previous(item1).should == nil }
    it { subject.previous(item2).should == item1 }
    it { subject.previous(item3).should == item2 }

  end


  describe 'self' do
    subject { Post }
    describe '#postname' do
      it { subject.postname('2013-09-14_First_Post').should == 'First post' }
      it { subject.postname('2013-09-15_Second_Post').should == 'Second post' }
      it { subject.postname('2013_09-15_secOnD_pOst').should == 'Second post' }
      it { subject.postname('2013-----09-_15_---secOnD___pOst').should == 'Second post' }
      it { subject.postname('2013-----09-_15_---Étoile').should == 'Étoile' }
      it { subject.postname('2013/Ireland/2013-09-14_First_Post').should == 'First post' }
    end
  end
end
