class AddPhoneTYpeToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :type_phone, :string
  end
end
