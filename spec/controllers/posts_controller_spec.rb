require 'spec_helper'

describe PostsController do

  describe '#index' do

    context 'Not loggued in' do
      it 'require a user' do
        get :index, user_id: 1
        response.should redirect_to new_user_session_path
      end
    end

    context 'loggued in' do
      let(:user) { FactoryGirl.create(:user) }
      let(:user2) { FactoryGirl.create(:user) }
      let(:post) { FactoryGirl.create(:post, user: user) }
      before :each do
        sign_in user
      end

      it 'redirect if trying to see somebody else posts' do
        get :index, { user_id: user2.id }
        response.should redirect_to user_posts_path(user_id: user)
      end

      it 'display the post' do
        get :index, { user_id: user.id }
        response.code.should == '200'
        assigns(:posts).should include post
      end

    end

  end

end
