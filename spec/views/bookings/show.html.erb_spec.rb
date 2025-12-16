require "rails_helper"

RSpec.describe "bookings/show", type: :view do
  let!(:user) { User.create!(email: "u_show@example.com", password: "password", password_confirmation: "password") }
  let!(:room) { Room.create!(name: "Room Show", capacity: 10) }

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

  it "renders attributes" do
    render
    expect(rendered).to include("Note")
    expect(rendered).to include("Room Show").or include(room.id.to_s)
  end
end
