class Address < ApplicationRecord
    belongs_to :provider, optional:true
    belongs_to :country, optional: true
    belongs_to :province, optional: true
    belongs_to :city, optional: true
    
end
  