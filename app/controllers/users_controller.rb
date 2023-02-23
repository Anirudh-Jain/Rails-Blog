class UsersController < ApplicationController
  before_action :find_user, only: %i[edit update show destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Magazine #{@user.first_name}, you have successfully signed up"
      redirect_to articles_path
    else
      render 'new', staus: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Account Info Updated'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @articles = @user.articles
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = 'Account and all associated Articles deleted'
    redirect_to articles_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :age, :email, :password, :avatar)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
