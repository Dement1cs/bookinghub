require "rails_helper"

RSpec.describe "bookings/index", type: :view do
  let!(:user) { User.create!(email: "u_index@example.com", password: "password", password_confirmation: "password") }
  let!(:room) { Room.create!(name: "Room B", capacity: 20) }

  before do
    assign(:bookings, [
      Booking.create!(note: "B1", room: room, user: user,
        starts_at: Time.zone.parse("2025-01-01 10:00"),
        ends_at:   Time.zone.parse("2025-01-01 11:00")
      ),
      Booking.create!(note: "B2", room: room, user: user,
        starts_at: Time.zone.parse("2025-01-01 12:00"),
        ends_at:   Time.zone.parse("2025-01-01 13:00")
      )
    ])
  end

  it "renders a list of bookings" do
    render

    expect(rendered).to include("Room B")
    expect(rendered).to include("u_index@example.com")

    expect(rendered).to include("2025-01-01 10:00")
    expect(rendered).to include("2025-01-01 11:00")
    expect(rendered).to include("2025-01-01 12:00")
    expect(rendered).to include("2025-01-01 13:00")
  end
end
