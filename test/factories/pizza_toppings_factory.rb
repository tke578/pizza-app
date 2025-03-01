FactoryBot.define do
  factory :pizza_toppings do
    association :pizza
    association :topping
  end
end
