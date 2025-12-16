class Room < ApplicationRecord
  has_many :bookings, dependent: :destroy

  validates :name, presence: true
  validates :capacity, presence: true,
                       numericality: { only_integer: true, greater_than: 0 }
end
