Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "welcome", to: "welcome#index"

      # Authentication routes
      post "auth/register", to: "auth#register"
      post "auth/login", to: "auth#login"
      delete "auth/logout", to: "auth#logout"
      get "auth/current_user", to: "auth#current_user_info"

      # Profile routes
      resource :profile, only: %i[show create update]

      # Member routes
      get "members", to: "members#index"

      # Work location routes
      get "work_locations/today", to: "work_locations#today"
      get "work_locations/history", to: "work_locations#history"
      resources :work_locations, only: %i[create update]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
