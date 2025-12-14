class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validate :end_after_start
  validate :no_overlap

  private

  def end_after_start
    return if starts_at.blank? || ends_at.blank?

    if ends_at <= starts_at
      errors.add(:ends_at, "must be after start time")
    end
  end

  def no_overlap
    return if starts_at.blank? || ends_at.blank? || room_id.blank?

    overlap = Booking
      .where(room_id: room_id)
      .where.not(id: id) # важно для update
      .where("starts_at < ? AND ends_at > ?", ends_at, starts_at)
      .exists?

    errors.add(:base, "This room is already booked for that time.") if overlap
  end
end
