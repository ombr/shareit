require 'spec_helper'

describe GroupsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:group) {FactoryGirl.create(:group, user: user)}

  describe '#index' do
    it 'redirect if not loggued in' do
      get :index
      response.should redirect_to new_user_session_path
    end

    context 'loggued in' do

      before(:each) do
        sign_in user
      end

      it 'return 200 code' do
        get :index
        response.code.should == '200'
      end

      it 'assigns the user group' do
        pending "Strange email already taken...."
        group
        get :index
        assigns(:groups).should == [group]
      end
    end
  end
end
