Rails.application.routes.draw do
  resources :users, only: %i[show edit update]
  resources :events
  root "events#index"
end
