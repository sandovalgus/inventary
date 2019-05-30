class AddReferencesToMoveDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :move_details, :site_from_id, :bigint, index: true
    add_column :move_details, :site_to_id, :bigint, index: true

    add_foreign_key :move_details, :deposits, column: :site_from_id, primary_key: :id
    add_foreign_key :move_details, :deposits, column: :site_to_id, primary_key: :id
  end
end
