class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items

  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: ['pending', 'completed'] }
end
