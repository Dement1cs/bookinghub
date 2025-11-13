class Room < ApplicationRecord
  has_many :bookings, dependent: :destroy

  validates :name, presence: true
  validates :capacity, numericality: { greater_than: 0 }
end
