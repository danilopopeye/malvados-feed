# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :strip do
    sequence(:number)
    previous { number - 1 }
    updated_at Time.now
    image 'http://host/image.ext'
    header 'http://host/header.ext'
  end
end
