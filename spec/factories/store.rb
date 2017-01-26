# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :store do
    retailer
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Number.number(7) }
    lat { Faker::Number.decimal(2) }
    long { Faker::Number.decimal(2) }
  end
end
