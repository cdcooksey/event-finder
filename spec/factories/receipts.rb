FactoryGirl.define do
  factory :receipt do
    store
    customer
    total_items { Faker::Number.number(2) }
  end
end
