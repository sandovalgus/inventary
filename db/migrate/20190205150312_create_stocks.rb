class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.integer :stock_min
      t.integer :reorder_point
      t.references :deposit, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
