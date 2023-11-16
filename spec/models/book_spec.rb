require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it 'requires title' do
      book = build(:book, title: nil)
      expect(book).not_to be_valid
      expect(book.errors[:title]).to include("can't be blank")
    end

    it 'requires author' do
      book = build(:book, author: nil)
      expect(book).not_to be_valid
      expect(book.errors[:author]).to include("can't be blank")
    end

    it 'requires genre' do
      book = build(:book, genre: nil)
      expect(book).not_to be_valid
      expect(book.errors[:genre]).to include("can't be blank")
    end

    it 'requires price to be greater than or equal to 0' do
      book = build(:book, price: -5)
      expect(book).not_to be_valid
      expect(book.errors[:price]).to include('must be greater than or equal to 0')
    end

    it 'requires published_year to be an integer greater than or equal to 0' do
      book = build(:book, published_year: 'not_an_integer')
      expect(book).not_to be_valid
      expect(book.errors[:published_year]).to include('is not a number')

      book = build(:book, published_year: -5)
      expect(book).not_to be_valid
      expect(book.errors[:published_year]).to include('must be greater than or equal to 0')

      book = build(:book, published_year: 2020)
      expect(book).to be_valid
    end
  end

  describe 'associations' do
    it 'has many reviews' do
      expect(Book.reflect_on_association(:reviews).macro).to eq(:has_many)
    end

    it 'has many order_items' do
      expect(Book.reflect_on_association(:order_items).macro).to eq(:has_many)
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:book)).to be_valid
    end
  end
end
