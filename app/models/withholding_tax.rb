class WithholdingTax < ApplicationRecord
    # belongs_to :Provideer
    #  has_one :Provideer
    # has_and_belongs_to_many :providers
    has_many :withholdings
    has_many :providers, :through => :withholdings

    validates :withholding, presence: :true
end
