require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:book) { FactoryBot.create(:book) }
  let(:review) { FactoryBot.create(:review, user: user, book: book) }

  describe 'GET #new' do
    it 'returns a successful response' do
      log_in user
      get :new, params: { book_id: book.id }
      expect(response).to be_successful
    end

    it 'renders the new template' do
      log_in user
      get :new, params: { book_id: book.id }
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new review' do
        log_in user
        expect {
          post :create, params: { book_id: book.id, review: FactoryBot.attributes_for(:review) }
        }.to change(Review, :count).by(1)
      end

      it 'redirects to the book show page' do
        log_in user
        post :create, params: { book_id: book.id, review: FactoryBot.attributes_for(:review) }
        expect(response).to redirect_to(book_path(book))
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new review' do
        log_in user
        expect {
          post :create, params: { book_id: book.id, review: FactoryBot.attributes_for(:review, rating: nil) }
        }.to_not change(Review, :count)
      end

      it 'renders the new template' do
        log_in user
        post :create, params: { book_id: book.id, review: FactoryBot.attributes_for(:review, rating: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      log_in user
      get :edit, params: { id: review.id, book_id: book.id }
      expect(response).to be_successful
    end

    it 'renders the edit template' do
      log_in user
      get :edit, params: { id: review.id, book_id: book.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'updates the review' do
        log_in user
        new_rating = 4
        put :update, params: { id: review.id, book_id: book.id, review: { rating: new_rating } }
        review.reload
        expect(review.rating).to eq(new_rating)
      end

      it 'redirects to the book show page' do
        log_in user
        put :update, params: { id: review.id, book_id: book.id, review: FactoryBot.attributes_for(:review) }
        expect(response).to redirect_to(book_path(book))
      end
    end

    context 'with invalid attributes' do
      it 'does not update the review' do
        log_in user
        original_rating = review.rating
        put :update, params: { id: review.id, book_id: book.id, review: { rating: nil } }
        review.reload
        expect(review.rating).to eq(original_rating)
      end

      it 'renders the edit template' do
        log_in user
        put :update, params: { id: review.id, book_id: book.id, review: { rating: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the review' do
      log_in user
      review_to_delete = FactoryBot.create(:review, user: user, book: book)
      expect {
        delete :destroy, params: { id: review_to_delete.id, book_id: book.id }
      }.to change(Review, :count).by(-1)
    end

    it 'redirects to the book show page' do
      log_in user
      delete :destroy, params: { id: review.id, book_id: book.id }
      expect(response).to redirect_to(book_path(book))
    end
  end
end
