class AddWithholdingStatusToProvider < ActiveRecord::Migration[5.2]
  def change
    add_column :providers, :withholdingstatus, :boolean, :default => false 
    end
end
