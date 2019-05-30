class CreateMoves < ActiveRecord::Migration[5.2]
  def change
    create_table :moves do |t|
      t.references :site_from
      t.references :site_to
      t.datetime :move_date
      t.references :user_register
      t.references :user_take
      t.string :ticket_type
      t.string :ticket_number

      t.timestamps
    end
    # Rails 5+ only: add foreign keys
    add_foreign_key :moves, :deposits, column: :site_from_id, primary_key: :id
    add_foreign_key :moves, :deposits, column: :site_to_id, primary_key: :id

    add_foreign_key :moves, :users, column: :user_register_id, primary_key: :id
    add_foreign_key :moves, :users, column: :user_take_id, primary_key: :id
  end
end
