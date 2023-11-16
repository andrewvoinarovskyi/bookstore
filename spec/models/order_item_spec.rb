require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:book) { FactoryBot.create(:book) }
  let(:order) { FactoryBot.create(:order, user: user) }

  describe 'associations' do
    it { expect(described_class.reflect_on_association(:order).macro).to eq(:belongs_to) }
    it { expect(described_class.reflect_on_association(:book).macro).to eq(:belongs_to) }
  end

  describe 'validations' do
    it 'requires order_id to be present' do
      order_item = build(:order_item, order_id: nil)
      expect(order_item).not_to be_valid
      expect(order_item.errors[:order]).to include("must exist")
    end


    it 'requires book_id to be present' do
      order_item = build(:order_item, book_id: nil)
      expect(order_item).not_to be_valid
      expect(order_item.errors[:book]).to include("must exist")
    end

    it 'requires quantity to be an integer greater than or equal to 1' do
      order_item = build(:order_item, quantity: 0.5)
      expect(order_item).not_to be_valid
      expect(order_item.errors[:quantity]).to include('must be an integer')

      order_item = build(:order_item, quantity: 0)
      expect(order_item).not_to be_valid
      expect(order_item.errors[:quantity]).to include('must be greater than or equal to 1')
    end

    it 'requires item_price to be a number greater than or equal to 0' do
      order_item = build(:order_item, item_price: 'not_a_number')
      expect(order_item).not_to be_valid
      expect(order_item.errors[:item_price]).to include('is not a number')

      order_item = build(:order_item, item_price: -1)
      expect(order_item).not_to be_valid
      expect(order_item.errors[:item_price]).to include('must be greater than or equal to 0')
    end
  end
end
