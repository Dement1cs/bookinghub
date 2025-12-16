require "rails_helper"

RSpec.describe "bookings/new", type: :view do
  before do
    assign(:booking, Booking.new)
  end

  it "renders new booking form" do
    render

    assert_select "form[action=?][method=?]", bookings_path, "post" do
      assert_select "[name='booking[starts_at]']"
      assert_select "[name='booking[ends_at]']"
      assert_select "[name='booking[note]']"
      assert_select "[name='booking[room_id]']"
      # user_id НЕ должно быть в форме
      assert_select "[name='booking[user_id]']", count: 0
    end
  end
end
