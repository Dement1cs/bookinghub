require "rails_helper"

RSpec.describe "bookings/edit", type: :view do
  let!(:user) { User.create!(email: "u1@example.com", password: "password", password_confirmation: "password") }
  let!(:room) { Room.create!(name: "Room A", capacity: 10) }
  let!(:booking) do
    Booking.create!(
      note: "Note",
      room: room,
      user: user,
      starts_at: Time.zone.parse("2025-01-01 10:00"),
      ends_at:   Time.zone.parse("2025-01-01 11:00")
    )
  end

  before do
    assign(:booking, booking)
  end

  it "renders the edit booking form" do
    render

    assert_select "form[action=?][method=?]", booking_path(booking), "post" do
      assert_select "[name='booking[starts_at]']"
      assert_select "[name='booking[ends_at]']"
      assert_select "[name='booking[note]']"
      assert_select "[name='booking[room_id]']"
      assert_select "[name='booking[user_id]']", count: 0
    end
  end
end
