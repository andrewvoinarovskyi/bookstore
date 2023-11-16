require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:book) { FactoryBot.create(:book) }

  describe 'associations' do
    it 'should have a user' do
      expect(described_class.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it 'should have a book' do
      expect(described_class.reflect_on_association(:book).macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      review = build(:review, book: book, user: user)
      expect(review).to be_valid
    end

    it 'is not valid without a rating' do
      review = described_class.new(rating: nil, comment: 'Great book!', user_id: 1, book_id: 2)
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("can't be blank")
    end

    it 'is not valid without a comment' do
      review = described_class.new(rating: 4, comment: nil, user_id: 1, book_id: 2)
      expect(review).not_to be_valid
      expect(review.errors[:comment]).to include("can't be blank")
    end

    it 'is not valid without a user_id' do
      review = described_class.new(rating: 4, comment: 'Great book!', user_id: nil, book_id: 2)
      expect(review).not_to be_valid
      expect(review.errors[:user_id]).to include("can't be blank")
    end

    it 'is not valid without a book_id' do
      review = described_class.new(rating: 4, comment: 'Great book!', user_id: 1, book_id: nil)
      expect(review).not_to be_valid
      expect(review.errors[:book_id]).to include("can't be blank")
    end
  end
end
