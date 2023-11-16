class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book

  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :item_price, numericality: { greater_than_or_equal_to: 0 }
end
