class CreateWithholdingTaxes < ActiveRecord::Migration[5.2]
  def change
    create_table :withholding_taxes do |t|
      t.string :withholding
      t.string :comment

      t.timestamps
    end
  end
end
