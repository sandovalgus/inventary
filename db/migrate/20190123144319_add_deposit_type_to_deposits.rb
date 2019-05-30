class AddDepositTypeToDeposits < ActiveRecord::Migration[5.2]
  def change
    add_reference :deposits, :deposit_type, foreign_key: true
  end
end


