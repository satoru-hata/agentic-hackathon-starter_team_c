FactoryBot.define do
  factory :work_location do
    association :user_profile
    status { ["office", "remote", "out_of_office"].sample }
    date { Date.current }
    
    trait :office do
      status { "office" }
    end
    
    trait :remote do
      status { "remote" }
    end
    
    trait :out_of_office do
      status { "out_of_office" }
    end
    
    trait :yesterday do
      date { Date.yesterday }
    end
    
    trait :tomorrow do
      date { Date.tomorrow }
    end
  end
end