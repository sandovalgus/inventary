class Stock < ApplicationRecord
  belongs_to :deposit
  belongs_to :product
end
