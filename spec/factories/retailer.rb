# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :retailer do
    name { Faker::Company.name }
  end
end
