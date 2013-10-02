FactoryGirl.define do
  factory :item do
    path '2013/2013-09-21-Day_One/image1.jpg'
    file { File.open File.join(Rails.root, 'spec', 'fixtures', 'image.jpg') }
  end
end
