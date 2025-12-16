FactoryBot.define do
  factory :booking do
    room
    user
    starts_at { Time.zone.parse("2025-12-15 10:00") }
    ends_at   { Time.zone.parse("2025-12-15 11:00") }
    note { "Test booking" }
  end
end
