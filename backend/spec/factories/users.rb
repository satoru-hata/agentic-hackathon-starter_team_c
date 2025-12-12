FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    password { "password123" }

    trait :with_profile do
      after(:create) do |user|
        create(:user_profile, user: user)
      end
    end
  end
end
