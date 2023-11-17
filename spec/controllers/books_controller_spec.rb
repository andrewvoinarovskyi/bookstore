require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:book) { FactoryBot.create(:book) }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns all books to @books' do
      book1 = FactoryBot.create(:book)
      book2 = FactoryBot.create(:book)

      get :index
      expect(assigns(:books)).to eq([book1, book2])
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: book.id }
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get :show, params: { id: book.id }
      expect(response).to render_template(:show)
    end

    it 'assigns the requested book to @book' do
      get :show, params: { id: book.id }
      expect(assigns(:book)).to eq(book)
    end
  end

  describe 'POST #purchase' do
    context 'when user is logged in' do
      before do
        log_in user
      end

      it 'creates an order for the current user' do
        post :purchase, params: { id: book.id }
        expect(user.orders.count).to eq(1)
      end

      it 'creates an order item for the purchased book' do
        post :purchase, params: { id: book.id }
        order_item = user.orders.first.order_items.first
        expect(order_item.book).to eq(book)
        expect(order_item.quantity).to eq(1)
      end

      it 'updates the order total price and status' do
        post :purchase, params: { id: book.id }
        order = user.orders.first
        expect(order.total_price).to eq(book.price)
        expect(order.status).to eq('completed')
      end

      it 'redirects to the purchased action' do
        post :purchase, params: { id: book.id }
        expect(response).to redirect_to(purchased_book_path)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to login_path with an alert' do
        post :purchase, params: { id: book.id }
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq('You must be logged in to purchase a book.')
      end
    end
    describe 'GET #purchased_books' do
      context 'when user is logged in' do
        before do
          log_in user
        end

        it 'returns a successful response' do
          get :purchased_books
          expect(response).to be_successful
        end

        it 'renders the purchased_books template' do
          get :purchased_books
          expect(response).to render_template(:purchased_books)
        end

        it 'assigns purchased books to @purchased_books' do
          post :purchase, params: { id: book.id }
          get :purchased_books
          expect(assigns(:purchased_books)).to eq([book])
        end
      end

      context 'when user is not logged in' do
        it 'redirects to login path with an alert' do
          get :purchased_books
          expect(response).to redirect_to(login_path)
          expect(flash[:alert]).to eq('You must be signed in to access this page.')
        end
      end
    end
  end
end
