class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book
  validates_presence_of :order_id, :book_id, :quantity, :item_price
end
