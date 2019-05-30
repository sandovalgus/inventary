class AddAddressToProvider < ActiveRecord::Migration[5.2]
  def change
    add_reference :addresses, :provider, foreign_key: true
  end
end
