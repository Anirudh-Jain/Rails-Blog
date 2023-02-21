class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    user = User.find_by(email: email)
    password = params[:session][:password]

    if !user.nil? && user.authenticate(password)
      session[:user_id] = user.id
      flash[:notice] = 'Logged In'
      redirect_to user
    else
      flash.now[:alert] = 'Incorrect Credentials'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged Out'
    redirect_to root_path
  end
end
