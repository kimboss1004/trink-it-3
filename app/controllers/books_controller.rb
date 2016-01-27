class BooksController < ApplicationController
  before_action :require_user, except: [:show]
  before_action :must_be_in_college, except: [:show, :new]

  def show
    @book = Book.find(params[:id])
    @message = Message.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.new(book_params) 
    @book.college = current_college
    if @book.save
      
      if params[:images]
        params[:images].each { |image|
          @book.images.create(image: image)
        }
      end
      redirect_to college_book_path(current_college, @book)
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update_attributes(book_params)
      if params[:images]
        params[:images].each { |image|
          @book.images.create(image: image)
        }
      end
      flash[:success] = "Your changes have been saved."
      redirect_to college_book_path(current_college, @book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])

    if creator?(@book.user)
      @book.destroy
      flash[:success] = "Your posting has been deleted."
      redirect_to college_path(current_college)
    else
      flash[:danger] = "You are not the creator of that post."
      redirect_to college_path(current_college)
    end
  end

  def my_books
    @books = Book.where(user: current_user).order("created_at DESC")
  end

  private
  def book_params 
    params.require(:book).permit(:title,:price,:description,:name,:condition,:swap,:category_id, :image)
  end

end