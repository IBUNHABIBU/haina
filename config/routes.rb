Rails.application.routes.draw do
  resources :customers
  resources :activities
  get '/dashboard', to: 'dashboard#index', as: 'dashboard'
  # Devise authentication
  devise_for :users, path: '', path_names: {
    sign_up: 'adminregister',
    sign_in: 'login',
    sign_out: 'logout'
  }

  # User management (only index, update, destroy)
  resources :users, only: [:index, :update, :destroy]

  # App resources

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  root "home#index"
end
