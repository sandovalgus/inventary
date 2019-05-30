class Deposit < ApplicationRecord
  belongs_to :country, optional: true
  belongs_to :province, optional: true
  belongs_to :city, optional: true
  belongs_to :deposit_type
  has_many :inventories

  extend Enumerize
  validates :name, presence: :true
  validates :deposit_type, presence: :true
  validates :country, presence: :true
  validates :province, presence: :true
  validates :city, presence: :true
  validates :address, presence: :true

  scope :sorted, -> { order(:name) }

end
  