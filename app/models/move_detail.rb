class MoveDetail < ApplicationRecord
  belongs_to :site_from, :class_name => "Deposit"
  belongs_to :site_to, :class_name => "Deposit"
  belongs_to :inventory
  belongs_to :move
end
