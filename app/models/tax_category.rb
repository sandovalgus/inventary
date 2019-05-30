class TaxCategory < ApplicationRecord
has_many :providers

validates :name, presence: :true
end
 