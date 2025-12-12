FactoryBot.define do
  factory :user_profile do
    association :user
    sequence(:name) { |n| "Test User #{n}" }
    department { ["Development", "Sales", "Marketing", "HR", "Finance"].sample }
  end
end