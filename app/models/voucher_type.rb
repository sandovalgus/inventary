class VoucherType < ApplicationRecord

    validates :name, presence: :true

    scope :sorted, -> { order(:name) }
end
