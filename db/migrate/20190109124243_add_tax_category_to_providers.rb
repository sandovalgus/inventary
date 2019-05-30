class AddTaxCategoryToProviders < ActiveRecord::Migration[5.2]
  def change
    add_reference :providers, :tax_category, foreign_key: true
  end
end
