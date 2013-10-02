require 'spec_helper'

describe ItemsController do
  let(:user) { FactoryGirl.create :user }
  let(:post) { subject.posts.first }
  subject { FactoryGirl.create :item, user: user }

  describe '#show' do
    it 'respond 200' do
      get :show, {
        user_id: user,
        post_id: post,
        id: subject
      }
      response.code.should == "200"
    end
  end

end
