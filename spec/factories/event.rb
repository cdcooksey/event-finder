# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    store
    customer
    lat { Faker::Number.decimal(2) }
    long { Faker::Number.decimal(2) }
    event_at "2014-05-21 16:44:17"
  end
end
