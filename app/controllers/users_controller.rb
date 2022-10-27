class UsersController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]

  def index
    @book = Book.new
    @user = current_user
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @users = User.all
      render:index
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully"
      redirect_to user_path(@user.id)
    else
      render:edit
    end  
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to (user_path) unless @user == current_user
  end
  
end
