class Book < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one_attached :cover
  has_many :reviews
  self.per_page =24
  scope :recommended_book, -> { joins(:reviews).order(rating: :desc).first}
  scope :recommended_book_score, -> {recommended_book.reviews.average(:rating).to_f.round(2)}

end
