require 'spec_helper'

describe WelcomeController do
  describe '#index' do

    let(:user) { FactoryGirl.create(:user) }
    let(:post) { FactoryGirl.create(:post, user: user) }

    describe '#index' do
      context 'Not loggued in' do
        it 'display the welcome message' do
          get :index
          response.code.should == '200'
        end
      end

      context 'loggued in' do
        before :each do
          sign_in user
        end

        it 'redirect to user home' do
          get :index
          response.should redirect_to user_path(id: user)
        end

      end
    end

  end
end
