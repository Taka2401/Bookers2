class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :baria_user, only: [:edit, :destroy, :update]


  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
  if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
  else
    @user = current_user
    @books = Book.all
    render :index
  end
  end

  def show
    @books = Book.all
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def update
    @books = Book.all
    @book = Book.find(params[:id])
    @user = @book.user
  if @book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path
  else
    render :index
  end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def baria_user
    unless Book.find(params[:id]).user.id.to_i == current_user.id
      redirect_to books_path
    end
  end

end
