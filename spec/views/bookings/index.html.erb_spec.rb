require 'rails_helper'

RSpec.describe "bookings/index", type: :view do
  before(:each) do
    assign(:bookings, [
      Booking.create!(
        note: "Note",
        room: nil,
        user: nil
      ),
      Booking.create!(
        note: "Note",
        room: nil,
        user: nil
      )
    ])
  end

  it "renders a list of bookings" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Note".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
