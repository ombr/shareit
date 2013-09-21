FactoryGirl.define do

  sequence :email do |k|
    "luc+#{k}@gmail.com"
  end
end
