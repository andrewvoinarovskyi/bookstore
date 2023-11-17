require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'should have many reviews' do
      expect(described_class.reflect_on_association(:reviews).macro).to eq :has_many
    end

    it 'should have many orders' do
      expect(described_class.reflect_on_association(:orders).macro).to eq :has_many
    end

    it 'belongs to a user' do
      expect(Order.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it 'has many order_items' do
      expect(Order.reflect_on_association(:order_items).macro).to eq(:has_many)
      expect(Order.reflect_on_association(:order_items).options[:dependent]).to eq(:destroy)
    end

    it 'has many books through order_items' do
      expect(Order.reflect_on_association(:books).macro).to eq(:has_many)
      expect(Order.reflect_on_association(:books).options[:through]).to eq(:order_items)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'is not valid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is not valid with a duplicate email' do
      existing_user = create(:user, email: 'duplicate@example.com')
      user = build(:user, email: 'duplicate@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('has already been taken')
    end

    # TODO: implement more security for users
    # uncomment when implemented
    # it 'is not valid with an invalid email format' do
    #   invalid_emails = ['user@com', 'user@.com', 'user@dot..com']
    #   invalid_emails.each do |email|
    #     user = build(:user, email: email)
    #     expect(user).not_to be_valid
    #     expect(user.errors[:email]).to include('is not an email')
    #   end
    # end
    #
    # it 'is not valid with a very long email address' do
    #   user = build(:user, email: 'a' * 256 + '@example.com')
    #   expect(user).not_to be_valid
    #   expect(user.errors[:email]).to include('is too long (maximum is 255 characters)')
    # end
    #
    # it 'is not valid with a password that is too short' do
    #   user = build(:user, password: 'pass', password_confirmation: 'pass')
    #   expect(user).not_to be_valid
    #   expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    # end
    #
    # it 'is not valid with a password confirmation that does not match' do
    #   user = build(:user, password: 'password', password_confirmation: 'different_password')
    #   expect(user).not_to be_valid
    #   expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    # end
    #
    # it 'is not valid without a password confirmation' do
    #   user = build(:user, password: 'password', password_confirmation: nil)
    #   expect(user).not_to be_valid
    #   expect(user.errors[:password_confirmation]).to include("can't be blank")
    # end
  end
end
