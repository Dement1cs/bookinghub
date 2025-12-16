require "rails_helper"

RSpec.describe Room, type: :model do
  it "is valid with name and capacity" do
    expect(Room.new(name: "Room A", capacity: 10)).to be_valid
  end

  it "is invalid without name" do
    expect(Room.new(name: nil, capacity: 10)).not_to be_valid
  end

  it "is invalid with non-positive capacity" do
    expect(Room.new(name: "Room A", capacity: 0)).not_to be_valid
  end
end

