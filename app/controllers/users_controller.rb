class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show]

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to the Magazine #{@user.first_name}, you have successfully signed up"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
  end

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

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :age, :email, :password, :avatar)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
