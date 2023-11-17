class BooksController < ApplicationController
  before_action :set_book, only: [:show, :purchase]

  def index
    @books = Book.all
  end

  def show
    @reviews = @book.reviews
  end

  def purchase
    if current_user
      order = current_user.orders.new(status: 'pending', total_price: 0)
      order.save

      order.order_items.create(book: @book, quantity: 1, item_price: @book.price)
      order.update(total_price: @book.price, status: 'completed')
      redirect_to root_path, notice: 'Book was successfully purchased.'
    else
      redirect_to login_path, alert: 'You must be logged in to purchase a book.'
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end
end
