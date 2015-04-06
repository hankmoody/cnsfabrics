require 'factory_girl'

FactoryGirl.define do

  factory :user do
    email "test@example.com"
    password "test1234"
  end

  factory :admin, class: User do
    email "test@example.com"
    password "test1234"
    admin true
  end

  factory :fabric do
    code "Cns1234"
    width 44
    quantity 105
    image File.new(Rails.root + 'spec/support/images/test_image.jpg')
    original_image File.new(Rails.root + 'spec/support/images/test_image.jpg')
  end
end
