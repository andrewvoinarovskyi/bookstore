FactoryBot.define do
  factory :order do
    total_price { 100.0 }
    status { 'pending' }
    association :user
  end
end
