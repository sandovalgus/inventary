class AddStatusColumnToMove < ActiveRecord::Migration[5.2]
  def change
    remove_column :moves, :ticket_type, :string
    remove_column :moves, :ticket_number, :string
    
    add_column :moves, :status, :string
    add_column :moves, :voucher_type, :string
    add_column :moves, :voucher_number, :string
  end
end
