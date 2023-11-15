require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should have_many(:reviews) }
  it { should have_many(:order_items) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:published_year) }
  it { should validate_presence_of(:genre) }
end
