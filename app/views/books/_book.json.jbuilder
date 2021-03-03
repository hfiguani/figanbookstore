json.extract! book, :id, :title, :ISBN, :description, :price, :quantity, :img, :author, :created_at, :updated_at
json.url book_url(book, format: :json)
