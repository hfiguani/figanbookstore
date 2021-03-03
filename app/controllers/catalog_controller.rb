class CatalogController < ApplicationController
  before_action :set_book, only: [:show]
  before_action :initialize_session
  before_action :load_cart

  # # GET /
  def index
     if params[:category].present?
      @category_id=Category.find_by(:name=>params[:category]).id
      @all_books=Book.where(:category_id=>@category_id, isPublished: :true).order("created_at DESC").paginate(page: params[:page],per_page: 24)
    else
      @all_books=Book.where(isPublished: :true).order("created_at DESC").paginate(page: params[:page],per_page: 24)
     end

  end
  # GET /catalog/0/1
  def show
      @book=Book.find_by(:id=>params[:book_id])
      if @book.reviews.blank?
        @average_review=0
      else
        @average_review=@book.reviews.average(:rating).to_f.round(2)
      end
  end
  # GET /
  def add_book_cart
    if user_signed_in?
    id=params[:id].to_i
    session[:cart]<<id unless session[:cart].include?(id)
    redirect_to root_path
    else
      flash[:notice]="Please sign in first or sign up if you don't have an account yet !"
      redirect_to root_path
    end
  end

  def orders
    @my_orders="You have no orders yet."
  end

  def load_cart
    @total=0
    @cart=Book.find(session[:cart])
    @cart.each do |c| @total+=c.price end
    @sales_tax=@total * 6.25/100
    @total_after_tax=@total + @sales_tax
  end
  def remove_from_cart
    id=params[:deleted_book_cart].to_i
    session[:cart].delete(id)
    redirect_to request.referer
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book=Book.find_by(:id=>params[:book_id])
  end
  def initialize_session
    session[:cart]||=[]
    if session[:cart].include?(0)
      session[:cart]=[]
    end
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:title, :ISBN, :description, :price, :quantity, :img, :author, :cover)
  end
  end


