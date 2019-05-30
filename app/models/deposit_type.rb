class DepositType < ApplicationRecord
    has_many :deposits
    # belongs_to :city
    validates :name, presence: :true
    scope :sorted, -> { order(:name) }
end
    