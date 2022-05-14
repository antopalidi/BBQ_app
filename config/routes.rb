Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/  do
    devise_for :users
    resources :users, only: %i[show edit update]
    resources :events do
      resources :comments, only: %i[create destroy]
      resources :subscriptions, only: %i[create destroy]
      resources :photos, only: %i[create destroy]
    end
    root to: "events#index"
  end
end
