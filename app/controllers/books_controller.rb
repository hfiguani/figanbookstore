class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]


  # GET /books
  # GET /books.json
  # # GET /books/category
  def index
    if params[:category].blank?
      @all_books=Book.all.order("created_at DESC").paginate(page: params[:page],per_page: 24)
    else
      @category_id=Category.find_by(:name=>params[:category]).id
      @all_books=Book.where(:category_id=>@category_id).order("created_at DESC").paginate(page: params[:page],per_page: 24)
    end
  end
  def unpublished
    @Unpub_books=Book.where(isPublished: :false).paginate(page: params[:page],per_page: 24)
  end
  # GET /books/1
  # GET /books/1.json
  def show
    if @book.reviews.blank?
      @average_review=0
    else
      @average_review=@book.reviews.average(:rating).round(2)
    end
  end
  # GET /books/new
  def new
    @book = current_user.books.build
    @categories=Category.all.map{|c| [c.name,c.id]}
  end

  # GET /books/1/edit
  def edit
    @categories=Category.all.map{|c| [c.name,c.id]}
  end

  # POST /books
  # POST /books.json
  def create
    @book = current_user.books.build(book_params)
    @book.category_id=params[:category_id]
    #@book.cover.attach(params[:cover])
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end
  def unpublish_book
    @book=Book.find(params[:id].to_i)
    @book.update(isPublished: :false)
    redirect_to books_path
  end
  def publish_book
    @book=Book.find(params[:id].to_i)
    @book.update(isPublished: :true)
    redirect_to unpublished_books_path
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :ISBN, :description, :price, :quantity, :isPublished, :author, :cover)
    end
end
