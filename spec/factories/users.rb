FactoryGirl.define do
  factory :user do
    email { FactoryGirl.generate :email }
    password 'myamazingpassword'
  end
end
