class RemoveSiteFromIdToMove < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :moves, { :column => :site_from_id }
    remove_foreign_key :moves, { :column => :site_to_id }
    
    remove_column :moves, :site_from_id
    remove_column :moves, :site_to_id
    
  end
end
