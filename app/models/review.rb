class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :book_id, :user_id, :rating, :comment, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
