require "rails_helper"

RSpec.describe Booking, type: :model do
  describe "validations" do
    it "is invalid when ends_at is before starts_at" do
      booking = build(:booking, starts_at: Time.zone.parse("2025-12-15 10:00"),
                               ends_at:   Time.zone.parse("2025-12-15 09:00"))
      expect(booking).not_to be_valid
      expect(booking.errors[:ends_at]).to include("must be after start time")
    end

    it "does not allow overlap in the same room" do
      room = create(:room)
      user1 = create(:user)
      user2 = create(:user)

      create(:booking, room: room, user: user1,
                       starts_at: Time.zone.parse("2025-12-15 10:00"),
                       ends_at:   Time.zone.parse("2025-12-15 12:00"))

      new_booking = build(:booking, room: room, user: user2,
                                    starts_at: Time.zone.parse("2025-12-15 11:00"),
                                    ends_at:   Time.zone.parse("2025-12-15 13:00"))

      expect(new_booking).not_to be_valid
      expect(new_booking.errors[:base]).to include("This room is already booked for that time.")
    end

    it "allows bookings that touch edges (end == start)" do
      room = create(:room)
      user = create(:user)

      create(:booking, room: room, user: user,
                       starts_at: Time.zone.parse("2025-12-15 10:00"),
                       ends_at:   Time.zone.parse("2025-12-15 12:00"))

      b2 = build(:booking, room: room, user: user,
                           starts_at: Time.zone.parse("2025-12-15 12:00"),
                           ends_at:   Time.zone.parse("2025-12-15 13:00"))

      expect(b2).to be_valid
    end

    it "allows overlap in different rooms" do
      room1 = create(:room)
      room2 = create(:room)
      user = create(:user)

      create(:booking, room: room1, user: user,
                       starts_at: Time.zone.parse("2025-12-15 10:00"),
                       ends_at:   Time.zone.parse("2025-12-15 12:00"))

      b2 = build(:booking, room: room2, user: user,
                           starts_at: Time.zone.parse("2025-12-15 11:00"),
                           ends_at:   Time.zone.parse("2025-12-15 13:00"))

      expect(b2).to be_valid
    end
  end
end

