require "rails_helper"

RSpec.describe "rooms/index", type: :view do
  before do
    assign(:rooms, [
      Room.create!(name: "Room A", capacity: 10),
      Room.create!(name: "Room B", capacity: 20)
    ])
  end

  it "renders a list of rooms" do
    render
    expect(rendered).to include("Room A")
    expect(rendered).to include("Room B")
  end
end
