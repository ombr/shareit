require 'spec_helper'

describe UsersController, focus: true do
  let(:user) { FactoryGirl.create(:user) }
  describe '#show' do
    before :each do
      get :show, id: user
    end
    it { response.code.should == '200' }

  end

end
