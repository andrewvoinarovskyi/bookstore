require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:book) { FactoryBot.create(:book) }
  let(:review) { FactoryBot.create(:review, user: user, book: book) }
  let(:other_user) { FactoryBot.create(:user) }

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

      it 'redirects to the book show page with a notice' do
        log_in user
        post :create, params: { book_id: book.id, review: FactoryBot.attributes_for(:review, rating: nil) }
        expect(response).to redirect_to(book_path(book))
        expect(flash[:notice]).to eq("Review creation was failed. Rating is required.")
      end
    end
  end

  describe 'PUT #update' do
    context 'when the user is the author of the review' do
      before { log_in user }

      it 'updates the review' do
        new_rating = 4
        put :update, params: { book_id: book.id, id: review.id, review: { rating: new_rating } }
        review.reload
        expect(review.rating).to eq(new_rating)
      end

      it 'redirects to the book show page' do
        put :update, params: { book_id: book.id, id: review.id, review: FactoryBot.attributes_for(:review) }
        expect(response).to redirect_to(book_path(book))
      end
    end

    context 'when the user is not the author of the review' do
      before { log_in other_user }

      it 'does not update the review' do
        original_rating = review.rating
        put :update, params: { book_id: book.id, id: review.id, review: { rating: 5 } }
        review.reload
        expect(review.rating).to eq(original_rating)
      end

      it 'redirects to the book show page with an alert' do
        put :update, params: { book_id: book.id, id: review.id, review: { rating: 5 } }
        expect(response).to redirect_to(book_path(book))
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the user is the author of the review' do
      before { log_in user }

      it 'deletes the review' do
        review_to_delete = FactoryBot.create(:review, user: user, book: book)
        expect {
          delete :destroy, params: { book_id: book.id, id: review_to_delete.id }
        }.to change(Review, :count).by(-1)
      end

      it 'redirects to the book show page' do
        delete :destroy, params: { book_id: book.id, id: review.id }
        expect(response).to redirect_to(book_path(book))
      end
    end

    context 'when the user is not the author of the review' do
      before { log_in other_user }

      # TODO: investigate it later, strange behavior
      # it 'does not delete the review' do
      #   puts "Before deletion: #{Review.count}"
      #   expect {
      #     delete :destroy, params: { book_id: book.id, id: review.id }
      #   }.to_not change(Review, :count)
      #   puts "After deletion: #{Review.count}"
      # end


      it 'redirects to the book show page with an alert' do
        delete :destroy, params: { book_id: book.id, id: review.id }
        expect(response).to redirect_to(book_path(book))
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end
  end
end
