class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :product_number
      t.string :name
      t.string :description
      t.string :type
      t.boolean :ac
      t.string :power_in
      t.string :power_out
      t.string :poe

      t.timestamps
    end
  end
end
