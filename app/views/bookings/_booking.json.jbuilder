json.extract! booking, :id, :starts_at, :ends_at, :note, :room_id, :user_id, :created_at, :updated_at
json.url booking_url(booking, format: :json)
