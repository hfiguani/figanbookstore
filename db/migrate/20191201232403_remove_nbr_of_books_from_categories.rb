class RemoveNbrOfBooksFromCategories < ActiveRecord::Migration[6.0]
  def change

    remove_column :categories, :Nbr_of_books, :integer
  end
end
