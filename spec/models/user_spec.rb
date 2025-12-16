require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid with email and password" do
    user = User.new(email: "u1@example.com", password: "password", password_confirmation: "password")
    expect(user).to be_valid
  end
end