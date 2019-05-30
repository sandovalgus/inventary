class AddContactRefToProvider < ActiveRecord::Migration[5.2]
  def change
    add_reference :contacts, :provider, foreign_key: true
  end
end
