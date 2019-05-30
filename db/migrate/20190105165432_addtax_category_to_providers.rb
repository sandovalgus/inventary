class AddtaxCategoryToProviders < ActiveRecord::Migration[5.2]
  def change
    add_column :providers, :tax_category_number, :string
    add_column :providers, :identification_number, :string
  end
end
