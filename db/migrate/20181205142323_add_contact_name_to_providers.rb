class AddContactNameToProviders < ActiveRecord::Migration[5.2]
  def change
    add_column :providers, :contact_name, :string
    add_column :providers, :email, :string
    add_column :providers, :website, :string

  end
end
