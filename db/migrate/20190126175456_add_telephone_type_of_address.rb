class AddTelephoneTypeOfAddress < ActiveRecord::Migration[5.2]
  def change
    add_reference :contacts, :telephone_type, foreign_key: true
  end
end
