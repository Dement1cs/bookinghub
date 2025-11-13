class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validate :end_after_start

  def end_after_start
    if starts_at && ends_at && ends_at <= starts_at
      errors.add(:ends_at, "must be after start")
    end
  end
end
