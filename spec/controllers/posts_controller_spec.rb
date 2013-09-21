require 'spec_helper'

describe PostsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, user: user) }

  describe '#index' do

    context 'Not loggued in' do
      it 'require a user' do
        get :index, user_id: 1
        response.should redirect_to new_user_session_path
      end
    end

    context 'loggued in' do
      before :each do
        sign_in user
      end

      let(:user2) { FactoryGirl.create(:user) }
      it 'redirect if trying to see somebody else posts' do
        get :index, { user_id: user2.id }
        response.should redirect_to user_posts_path(user_id: user)
      end

      it 'display the posts' do
        get :index, { user_id: user.id }
        response.code.should == '200'
        assigns(:posts).should include post
      end

    end
  end

  describe '#show' do
    context 'loggued in' do
      before :each do
        sign_in user
      end


      let(:user2) { FactoryGirl.create(:user) }
      it 'redirect if trying to see somebody else posts' do
        get :index, { user_id: user2.id }
        response.should redirect_to user_posts_path(user_id: user)
      end

      it 'assign the post' do
        get :show, {user_id: user.id, id: post}
        assigns(:post).should == post
        response.code.should == '200'
      end

      it 'return 200' do
        xhr :get, :show, {user_id: user.id, id: post}
        response.code.should == '200'
      end
    end

  end

end
