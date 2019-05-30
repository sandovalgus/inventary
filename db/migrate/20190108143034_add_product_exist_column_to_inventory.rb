class AddProductExistColumnToInventory < ActiveRecord::Migration[5.2]
  def change
    add_column :inventories, :product_exist, :boolean
  end
end
