require 'rails_helper'

RSpec.describe "bookings/edit", type: :view do
  let(:booking) {
    Booking.create!(
      note: "MyString",
      room: nil,
      user: nil
    )
  }

  before(:each) do
    assign(:booking, booking)
  end

  it "renders the edit booking form" do
    render

    assert_select "form[action=?][method=?]", booking_path(booking), "post" do

      assert_select "input[name=?]", "booking[note]"

      assert_select "input[name=?]", "booking[room_id]"

      assert_select "input[name=?]", "booking[user_id]"
    end
  end
end
