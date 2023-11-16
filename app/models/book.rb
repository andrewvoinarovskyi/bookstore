class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :order_items, dependent: :destroy

  validates :title, presence: true
  validates :author, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :published_year, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :genre, presence: true
end
