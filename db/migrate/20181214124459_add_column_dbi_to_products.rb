class AddColumnDbiToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :dbi, :string
  end
end
