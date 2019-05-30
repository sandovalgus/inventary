class ChangedEposiTtYpecolumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :deposit_types, :deposit_type, :name
  end
end
