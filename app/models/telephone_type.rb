class TelephoneType < ApplicationRecord
    scope :sorted, -> { order(:name) }
end
