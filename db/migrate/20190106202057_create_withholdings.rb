class CreateWithholdings < ActiveRecord::Migration[5.2]
  def change
    create_table :withholdings do |t|
      t.references :provider, index: true, foreign_key: true
      t.references :withholding_tax, index: true, foreign_key: true
    
      t.timestamps
    end
  end
end
