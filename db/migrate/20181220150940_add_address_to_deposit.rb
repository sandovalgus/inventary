class AddAddressToDeposit < ActiveRecord::Migration[5.2]
  def change
    add_column :deposits, :address, :string
    add_reference :deposits, :city, foreign_key: true
    add_reference :deposits, :province, foreign_key: true
    add_reference :deposits, :country, foreign_key: true
  end
end
