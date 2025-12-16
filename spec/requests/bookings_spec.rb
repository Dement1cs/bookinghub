require "rails_helper"

RSpec.describe "/rooms", type: :request do
  let!(:user) do
    User.create!(email: "test@example.com", password: "password", password_confirmation: "password")
  end

  before do
    sign_in user
  end

  let(:valid_attributes) do
    { name: "Room A", capacity: 10 }
  end

  let(:invalid_attributes) do
    { name: "", capacity: 0 }
  end

  describe "GET /index" do
    it "renders a successful response" do
      Room.create!(valid_attributes)
      get rooms_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      room = Room.create!(valid_attributes)
      get room_url(room)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_room_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      room = Room.create!(valid_attributes)
      get edit_room_url(room)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Room" do
        expect {
          post rooms_url, params: { room: valid_attributes }
        }.to change(Room, :count).by(1)
      end

      it "redirects to the created room" do
        post rooms_url, params: { room: valid_attributes }
        expect(response).to redirect_to(room_url(Room.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Room" do
        expect {
          post rooms_url, params: { room: invalid_attributes }
        }.not_to change(Room, :count)
      end

      it "renders a response with 422 status" do
        post rooms_url, params: { room: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PATCH /update" do
    let(:new_attributes) do
      { name: "Room Updated", capacity: 15 }
    end

    context "with valid parameters" do
      it "updates the requested room" do
        room = Room.create!(valid_attributes)
        patch room_url(room), params: { room: new_attributes }
        room.reload
        expect(room.name).to eq("Room Updated")
        expect(room.capacity).to eq(15)
      end

      it "redirects to the room" do
        room = Room.create!(valid_attributes)
        patch room_url(room), params: { room: new_attributes }
        expect(response).to redirect_to(room_url(room))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status" do
        room = Room.create!(valid_attributes)
        patch room_url(room), params: { room: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested room" do
      room = Room.create!(valid_attributes)
      expect {
        delete room_url(room)
      }.to change(Room, :count).by(-1)
    end

    it "redirects to the rooms list" do
      room = Room.create!(valid_attributes)
      delete room_url(room)
      expect(response).to redirect_to(rooms_url)
    end
  end
end
