FactoryBot.define do
  factory :room do
    sequence(:name) { |n| "Room #{n}" }
    capacity { 10 }
  end
end
