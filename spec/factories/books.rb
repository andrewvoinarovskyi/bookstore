FactoryBot.define do
  factory :book do
    title { 'Sample Book' }
    author { 'John Doe' }
    price { 19.99 }
    published_year { 2022 }
    genre { 'Fiction' }
  end
end
