class AddVoucherTypeReferencesToMove < ActiveRecord::Migration[5.2]
  def change
    unless column_exists? :moves, :voucher_type
      remove_column :moves, :voucher_type, :string
    end
    add_reference :moves, :voucher_type, foreign_key: true
  end
end
