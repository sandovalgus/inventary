class RemoveContryFromAddress < ActiveRecord::Migration[5.2]
  def change
    unless column_exists? :addresses, :city
      add_column :addresses, :city, :string
    end
    unless column_exists? :addresses, :country
      add_column :addresses, :country, :string
    end
    unless column_exists? :addresses, :state
      add_column :addresses, :state, :string
    end
    add_reference :addresses, :city, foreign_key: true
    add_reference :addresses, :province, foreign_key: true
    add_reference :addresses, :country, foreign_key: true
  end
end
