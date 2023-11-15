require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { should belong_to(:order) }
  it { should belong_to(:book) }
  it { should validate_presence_of(:order_id) }
  it { should validate_presence_of(:book_id) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:item_price) }
end
