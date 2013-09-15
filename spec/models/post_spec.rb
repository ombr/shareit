# encoding: utf-8
require 'spec_helper'

describe Post do
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
