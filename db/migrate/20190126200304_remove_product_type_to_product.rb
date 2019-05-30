class RemoveProductTypeToProduct < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :product_type, :string
  end
end
