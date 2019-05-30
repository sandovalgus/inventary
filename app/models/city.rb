class City < ApplicationRecord
  belongs_to :province
  has_many :technical_services, dependent: :restrict_with_error
  has_many :deposits
  validates :name, presence: true

  scope :sorted, -> { order(:name) }
end
