class ApplicationController < ActionController::Base
    # GET /admin
  def admin
    @books = Book.all
  end

end
