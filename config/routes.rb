Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :otps
      resources :cars do
        resource :locations, only: [:create]
      end
      resources :bookings do
        resources :reviews, only: [:create]
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
