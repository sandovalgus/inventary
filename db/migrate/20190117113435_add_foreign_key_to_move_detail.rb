class AddForeignKeyToMoveDetail < ActiveRecord::Migration[5.2]
  def change
    add_index :move_details, :site_from_id
    add_index :move_details, :site_to_id
  end
end
