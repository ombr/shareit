# encoding: utf-8
require 'spec_helper'

describe Post do

  it { should belong_to(:user) }
  it { should have_and_belong_to_many(:items) }
  it { should validate_uniqueness_of(:path).scoped_to(:user_id) }

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
    #let (:file1) { File.open(File.join(Rails.root, 'spec', 'fixtures', 'canon-ixus.jpg'))}
    #let (:file2) { File.open(File.join(Rails.root, 'spec', 'fixtures', 'canon-ixus.jpg'))}
    #let :item1, {FactoryGirl.create(:item, file: file1, path: 'test1.jpg')}
    #let :item1, {FactoryGirl.create(:item, file: file2, path: 'test2.jpg')}

    #describe 'started_at' do
      #it 'returns the right started_at date' do
        #item1
        #item2
        #item1.posts.first.started_at.should == "Thu, 12 Apr 2001 18:33:14 UTC +00:00"
      #end

      #it 'returns the right started_at date' do
        #item2
        #item1
        #item2.posts.first.started_at.should == "Thu, 12 Apr 2001 18:33:14 UTC +00:00"
      #end
    #end


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
