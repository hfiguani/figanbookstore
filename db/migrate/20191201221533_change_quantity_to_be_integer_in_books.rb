class ChangeQuantityToBeIntegerInBooks < ActiveRecord::Migration[6.0]
  def change
    change_column :Books, :quantity, :integer
  end
end
