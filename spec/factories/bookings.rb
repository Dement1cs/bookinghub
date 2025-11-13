FactoryBot.define do
  factory :booking do
    starts_at { "2025-11-12 23:24:13" }
    ends_at { "2025-11-12 23:24:13" }
    note { "MyString" }
    room { nil }
    user { nil }
  end
end
