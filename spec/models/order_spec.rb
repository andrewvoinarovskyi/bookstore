require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:order_items) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:total_price) }
  it { should validate_presence_of(:status) }
end
