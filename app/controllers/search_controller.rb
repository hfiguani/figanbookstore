class SearchController < ApplicationController
  def index
    @search = params[:search][:key_word]
    if @search.blank?
      @books=Book.all
    else
    @books=Book.where("lower(title) LIKE ?", "%" + @search.downcase + "%")
    end
  end
end
