class CreateInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :inventories do |t|
      t.references :product, foreign_key: true
      t.references :deposit, foreign_key: true
      t.string :firmware_version
      t.string :serial_number
      t.string :mac_address

      t.timestamps
    end
  end
end
