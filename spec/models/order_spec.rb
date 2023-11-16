require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      expect(Order.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it 'has many order_items' do
      expect(Order.reflect_on_association(:order_items).macro).to eq(:has_many)
      expect(Order.reflect_on_association(:order_items).options[:dependent]).to eq(:destroy)
    end
  end

  describe 'validations' do
    it 'requires user_id to be present' do
      order = Order.new(total_price: 100, status: 'pending')
      expect(order.valid?).to be_falsey
      expect(order.errors[:user]).to include("must exist")
    end

    it 'requires total_price to be present' do
      order = Order.new(user_id: 1, status: 'pending')
      expect(order.valid?).to be_falsey
      expect(order.errors[:total_price]).to include("is not a number")
    end

    it 'requires status to be present' do
      order = Order.new(user_id: 1, total_price: 100)
      expect(order.valid?).to be_falsey
      expect(order.errors[:status]).to include("is not included in the list")
    end
  end
end