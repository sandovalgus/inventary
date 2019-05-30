class ChangeTypeOfDepositType < ActiveRecord::Migration[5.2]
  def change
    remove_column :deposit_types, :type, :string
    add_column :deposit_types, :deposit_type, :string
  end
end
