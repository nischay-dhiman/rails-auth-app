Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, controllers: { sessions: 'users/sessions' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  authenticated :user do
    get 'profile', to: 'profiles#show', as: :user_profile
    post 'profile/enable_otp'
    post 'profile/disable_otp'
    get 'users/two_factor_authentication/show_qr', to: 'users/two_factor_authentication#show_qr', as: :show_otp_qr
  end

  # Defines the root path route ("/")
  # root "posts#index"

  root to: "home#index", via: [:get, :post]
end
