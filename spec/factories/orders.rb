FactoryBot.define do
  factory :order do
    total_price { 100.0 }  # Adjust the total_price based on your requirements
    status { 'pending' }    # Adjust the status based on your requirements
    association :user
  end
end
