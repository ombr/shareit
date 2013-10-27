require 'spec_helper'

describe Devise::OmniauthCallbacksController do
  describe '#facebook' do
    before do 
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        "provider"  => "facebook",
        "uid"       => '12345',
        "info" => {
          "first_name" => "John",
          "last_name"  => "Doe",
          "name"       => "John Doe"
        }, 
        'credentials' => OmniAuth::AuthHash.new({
          token: 'sdfsdf',
          expires: true,
          expires_at: 1386835797
        })
      })
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    end

    it 'raise an error if not loggued in' do
      expect{
        get :facebook
      }.to raise_error
    end

    context 'loggued in' do
      let(:user) { FactoryGirl.create :user }
      before :each do
        sign_in user
      end
      it 'redirect_to root_path' do
        get :facebook
        response.should redirect_to root_path
      end
      it 'assign the facebook credential' do
        get :facebook
        user.reload
        user.facebook_credentials.should == request.env["omniauth.auth"].credentials.to_hash
      end
      it 'create a background job' do
        expect {
          get :facebook
        }.to change{Delayed::Job.count}.by 1
        #Facebook.delay.import user
      end
    end

  end
end
