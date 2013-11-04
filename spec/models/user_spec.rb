require 'spec_helper'

describe User do
  it { should have_many(:posts) }
  it { should have_many(:items) }
  it { should have_many(:groups) }
  it { should have_many(:memberships) }

  describe '#avatar' do
    subject{ FactoryGirl.create :user }
    it { subject.avatar(100).should == GravatarImageTag.gravatar_url(subject.email, size: 100)}

    context 'with facebook account linked' do
      subject{ FactoryGirl.create :user, :with_facebook }
      it { subject.avatar(100).should == "http://graph.facebook.com/#{subject.uid}/picture?width=100&height=100" }
    end


  end
end
