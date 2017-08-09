Rails.application.routes.draw do
  get 'dashboard', to: 'dashboard#index'
  get 'search', to: 'search#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    resources :availabilities
  end

  root to: 'home#index'
end
