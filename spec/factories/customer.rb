# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    customer_id { Faker::Lorem.characters(32) }
    zip { Faker::Number.number(7) }
    lat { Faker::Number.decimal(2) }
    long { Faker::Number.decimal(2) }
  end
end