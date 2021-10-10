class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :editing_user, only: [:edit]

    def show
    @booknew = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    # @user = User.find(@book.user_id)
    @book_comment = BookComment.new
    @book_comments = @book.book_comments
  end

  def index
    @booknew = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @booknew = Book.new(book_params)
    @booknew.user_id = current_user.id
    if @booknew.save
      redirect_to book_path(@booknew.id), notice: "You have created book successfully."
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params[:book].permit(:title,:body)
  end

  def editing_user
    book = Book.find(params[:id])
    if book.user != current_user
      redirect_to books_path
    end
  end
end