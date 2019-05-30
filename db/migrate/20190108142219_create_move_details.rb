class CreateMoveDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :move_details do |t|
      t.references :inventory, foreign_key: true
      t.references :move, foreign_key: true

      t.timestamps
    end
  end
end
