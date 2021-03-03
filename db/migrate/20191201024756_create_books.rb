class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :ISBN
      t.text :description
      t.float :price
      t.float :quantity
      t.string :img
      t.string :author

      t.timestamps
    end
  end
end
