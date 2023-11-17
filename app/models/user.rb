class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :purchased_books, through: :orders, source: :books

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
