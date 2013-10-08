require 'spec_helper'

describe ItemsController do
  let(:user) { FactoryGirl.create :user }
  let(:item) { FactoryGirl.create :item, user: user }
  let(:post) { item.posts.first }

  describe '#show' do

    it 'should redirect' do
      get :show, {
        user_id: user,
        post_id: post,
        id: item
      }
      response.should redirect_to new_user_session_path
    end
    context 'loggued in' do
      before :each do
        sign_in user
      end

      let(:user2) { FactoryGirl.create(:user) }
      it 'redirect if trying to see somebody else items' do
        sign_in user2
        get :show, {
          user_id: user,
          post_id: post,
          id: item
        }
        response.should redirect_to user_path(id: user2)
      end

      it 'assign the post' do
        get :show, {
          user_id: user,
          post_id: post,
          id: item
        }
        assigns(:post).should == post
      end

      it 'assign the user' do
        get :show, {
          user_id: user,
          post_id: post,
          id: item
        }
        assigns(:user).should == user
      end

      it 'assign the item' do
        get :show, {
          user_id: user,
          post_id: post,
          id: item
        }
        assigns(:item).should == item
      end

      context 'with next and previous item' do
        let (:file1) { File.open(File.join(Rails.root, 'spec', 'fixtures', 'fujifilm-mx1700.jpg')) }
        let (:file2) { File.open(File.join(Rails.root, 'spec', 'fixtures', 'fujifilm-dx10.jpg')) }
        let (:file3) { File.open(File.join(Rails.root, 'spec', 'fixtures', 'canon-ixus.jpg')) }
        let (:item1) { FactoryGirl.create(:item, file: file1, path: 'test1.jpg', user: user) }
        let (:item3) { FactoryGirl.create(:item, file: file3, path: 'test3.jpg', user: user) }

        let (:item) { FactoryGirl.create(:item, file: file2, path: 'test2.jpg', user: user) }

        before :each do
          item1
          item
          item3
          get :show, {
            user_id: user,
            post_id: post,
            id: item
          }
        end
        it 'assigns next with the next item' do
          assigns(:next).should == item3
        end

        it 'assigns previous with the previous item' do
          assigns(:previous).should == item1
        end

      end

    end
  end

end
