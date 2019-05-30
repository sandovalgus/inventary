class CreateDeposits < ActiveRecord::Migration[5.2]
  def change
    create_table :deposits do |t|
      t.string :name
      t.string :description
      t.string :type

      t.timestamps
    end
  end
end
