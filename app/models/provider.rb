class Provider < ApplicationRecord
	has_many :contacts, dependent: :destroy
	has_many :addresses, dependent: :destroy
	# has_many :withholding_taxes
	has_many :withholdings
	has_many :withholding_taxes, through: :withholdings
	belongs_to :tax_category

	accepts_nested_attributes_for :contacts, allow_destroy: true
	accepts_nested_attributes_for :addresses, allow_destroy: true
	# accepts_nested_attributes_for :withholding_taxes, allow_destroy: true



	validates :name, presence: :true
end
  