FactoryGirl.define do
  factory :user do
    email { FactoryGirl.generate :email }
    password 'myamazingpassword'
    trait :with_facebook do
      facebook_credentials do
        {'token' => 'super_token', 'expires_at' => 1387905326, 'expires' => true}
      end
    end
  end
end
