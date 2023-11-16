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
      book = FactoryBot.create(:book)

      get :show, params: { id: book.id }
      expect(assigns(:book)).to eq(book)
    end
  end

  describe 'POST #purchase' do
    it 'creates an order for the current user' do
      log_in user
      post :purchase, params: { id: book.id }
      expect(user.orders.count).to eq(1)
    end

    it 'creates an order item for the purchased book' do
      log_in user
      post :purchase, params: { id: book.id }
      order_item = user.orders.first.order_items.first
      expect(order_item.book).to eq(book)
      expect(order_item.quantity).to eq(1)
    end

    it 'redirects to the root path with a success notice' do
      log_in user
      post :purchase, params: { id: book.id }
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Book was successfully purchased.')
    end
  end
end
