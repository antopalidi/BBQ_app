Rails.application.routes.draw do
  devise_for :users,
             skip: [:session, :password, :registration],
             controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    devise_for :users, controllers: {
      registration: 'registrations'
    }, skip: :omniauth_callbacks

    root to: "events#index"

    resources :users, only: %i[show edit update]

    resources :events do
      resources :comments, only: %i[create destroy]
      resources :subscriptions, only: %i[create destroy]
      resources :photos, only: %i[create destroy]

      post :show, on: :member
    end
  end
  get '/politica', :to => redirect('/politica.html')
end
