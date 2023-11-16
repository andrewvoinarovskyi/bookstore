FactoryBot.define do
  factory :review do
    rating { rand(1..5) }
    comment { 'A sample comment for the review. The second sentence.' } # Provide a specific comment or leave it blank
    association :user
    association :book
  end
end