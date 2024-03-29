class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def new
    @review = @book.reviews.build
  end

  def create
    @review = @book.reviews.build(review_params.merge(user: current_user))

    if @review.save
      redirect_to @book, notice: 'Review was successfully created.'
    else
      if review_params[:rating].empty?
        redirect_to book_path(@book), notice: 'Review creation was failed. Rating is required.'
      else
        redirect_to book_path(@book), notice: 'Review creation was failed. Comment is required.'
      end
    end
  end

  def edit
    # Review is already set by the before_action
  end

  def update
    if @review.update(review_params)
      redirect_to @book, notice: 'Review was successfully updated.'
    else
      redirect_to book_path(@book), notice: 'Review updating was failed.'
    end
  end

  def destroy
    @review.destroy
    redirect_to @book, notice: 'Review was successfully destroyed.'
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_review
    @review = @book.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def authorize_user
    unless current_user == @review.user
      redirect_to book_path(@book), alert: 'You are not authorized to perform this action.'
    end
  end
end
