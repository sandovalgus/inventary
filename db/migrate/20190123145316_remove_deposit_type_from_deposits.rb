class RemoveDepositTypeFromDeposits < ActiveRecord::Migration[5.2]
  def change
    remove_column :deposits, :deposit_type, :string
  end
end
