# spec/requests/bookings_spec.rb
require "rails_helper"

RSpec.describe "/bookings", type: :request do
  # Helper: stable ISO8601 strings for datetime params
  def dt(str)
    Time.zone.parse(str).iso8601
  end

  let!(:room) { create(:room) }
  let!(:user) { create(:user) }

  describe "GET /index" do
    context "when not signed in" do
      it "redirects to the sign-in page" do
        get bookings_url
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when signed in" do
      before { sign_in user }

      it "shows only the current user's bookings" do
        other_user = create(:user)
        other_room = create(:room)

        create(:booking,
               user: user,
               room: room,
               starts_at: Time.zone.parse("2025-12-15 10:00"),
               ends_at:   Time.zone.parse("2025-12-15 11:00"))

        create(:booking,
               user: other_user,
               room: other_room,
               starts_at: Time.zone.parse("2025-12-15 12:00"),
               ends_at:   Time.zone.parse("2025-12-15 13:00"))

        get bookings_url
        expect(response).to be_successful

    
        expect(response.body).to include(user.email)
        expect(response.body).not_to include(other_user.email)
      end
    end
  end

  describe "POST /create" do
    before { sign_in user }

    let(:valid_attributes) do
      {
        room_id: room.id,
        starts_at: dt("2025-12-15 10:00"),
        ends_at:   dt("2025-12-15 11:00"),
        note: "Test booking"
      }
    end

    it "creates a booking for the current user" do
      expect {
        post bookings_url, params: { booking: valid_attributes }
      }.to change(Booking, :count).by(1)

      booking = Booking.last
      expect(booking.user).to eq(user)
      expect(response).to redirect_to(booking_url(booking))
    end

    it "rejects overlapping bookings for the same room" do
      create(:booking,
             user: user,
             room: room,
             starts_at: Time.zone.parse("2025-12-15 10:00"),
             ends_at:   Time.zone.parse("2025-12-15 11:00"))

      overlapping = {
        room_id: room.id,
        starts_at: dt("2025-12-15 10:30"),
        ends_at:   dt("2025-12-15 11:30"),
        note: "Overlapping"
      }

      expect {
        post bookings_url, params: { booking: overlapping }
      }.not_to change(Booking, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("This room is already booked for that time.")
    end
  end

  describe "authorization (cannot access someone else's booking)" do
    before { sign_in user }

    it "redirects from SHOW" do
      other_user = create(:user)
      other_booking = create(:booking, user: other_user, room: room)

      get booking_url(other_booking)
      expect(response).to redirect_to(bookings_url)

      follow_redirect!
      expect(response.body).to include("You are not allowed to access this booking.")
    end

    it "redirects from EDIT" do
      other_user = create(:user)
      other_booking = create(:booking, user: other_user, room: room)

      get edit_booking_url(other_booking)
      expect(response).to redirect_to(bookings_url)
    end

    it "does not allow UPDATE" do
      other_user = create(:user)
      other_booking = create(:booking, user: other_user, room: room)

      patch booking_url(other_booking), params: { booking: { note: "hacked" } }
      expect(response).to redirect_to(bookings_url)

      other_booking.reload
      expect(other_booking.note).not_to eq("hacked")
    end

    it "does not allow DESTROY" do
      other_user = create(:user)
      other_booking = create(:booking, user: other_user, room: room)

      expect {
        delete booking_url(other_booking)
      }.not_to change(Booking, :count)

      expect(response).to redirect_to(bookings_url)
    end
  end
end
