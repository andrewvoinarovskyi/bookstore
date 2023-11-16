class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user

  helper_method :current_user, :logged_in?

  private

  def authenticate_user!
    unless current_user
      flash[:alert] = 'You must be signed in to access this page.'
      redirect_to login_page_path
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
