class CreateVoucherTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :voucher_types do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
