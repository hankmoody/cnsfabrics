require 'factory_girl'

FactoryGirl.define do
  factory :fabric do
    code "Cns1234"
    width 44
    quantity 105
    image File.new(Rails.root + 'spec/support/images/test_image.png')
  end
end
