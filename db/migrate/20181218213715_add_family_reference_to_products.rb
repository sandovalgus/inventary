class AddFamilyReferenceToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :family, foreign_key: true
  end
end
