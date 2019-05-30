class AddColumnIntoProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :stock_min_default, :integer
    add_column :products, :reorder_point_default, :integer
  end
end
