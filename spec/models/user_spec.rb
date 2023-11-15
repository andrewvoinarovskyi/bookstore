require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:reviews) }
  it { should have_many(:orders) }
  it { should have_secure_password }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
end
