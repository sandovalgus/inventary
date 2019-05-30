class AddProviderToInventory < ActiveRecord::Migration[5.2]
  def change
    add_reference :inventories, :provider, foreign_key: true
  end
end
