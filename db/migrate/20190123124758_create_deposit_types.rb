class CreateDepositTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :deposit_types do |t|
      t.string :type
      t.string :description

      t.timestamps
    end
  end
end
