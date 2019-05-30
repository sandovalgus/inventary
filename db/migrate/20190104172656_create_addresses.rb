class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :house_number
      t.string :neighborhood
      t.string :block
      t.string :floor
      t.string :number_department

      t.timestamps
    end
  end
end
