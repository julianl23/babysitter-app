Rails.application.routes.draw do
  resources :bookings
  get 'dashboard', to: 'dashboard#index'
  get 'search', to: 'search#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    root 'dashboard#index'
    resources :availabilities
  end

  resources :bookings do
    member do
      post 'accept'
      post 'decline'
    end
  end

  root to: 'home#index'
end
