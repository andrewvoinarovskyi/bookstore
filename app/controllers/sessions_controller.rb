class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to root_path
    end
    # Open login page
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      log_in user
      redirect_to root_path, notice: 'Logged in successfully.'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path, notice: 'Logged out successfully.'
  end
end
