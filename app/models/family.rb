class Family < ApplicationRecord
  belongs_to :producer
  # has_many :inventories
  scope :sorted, -> { order(:name) }
  validates :name, presence: :true
end
 