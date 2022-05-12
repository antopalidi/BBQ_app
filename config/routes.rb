Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/  do
    devise_for :users
    resources :users, only: %i[show edit update]
    resources :events
    root to: "events#index"
  end
end
