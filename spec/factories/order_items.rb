FactoryBot.define do
  factory :order_item do
    association :order
    association :book
    quantity { 1 }
    item_price { 9.99 }
  end
end
