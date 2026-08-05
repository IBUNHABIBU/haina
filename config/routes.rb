Rails.application.routes.draw do
  resources :videos
  resources :gears
  resources :team_members
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
  resources :bookings
  resources :destinations
  resources :heros

  resource :hero, only: [:show, :new, :create, :edit, :update, :destroy] do
    get 'gallery', on: :member
  end

# Or if you want a simpler URL:
get 'gallery', to: 'heros#gallery'

  # SEO-friendly routes
  resources :travel_tours, path: 'tours'
  resources :trekkings, path: 'treks' 
  resources :safaris, path: 'wildlife-safaris'
  resources :testimonials, path: 'reviews'

  resources :travel_tours do
    member do
      delete 'purge_image/:image_id', to: 'travel_tours#purge_image', as: :purge_image
    end
  end

  # Static pages
  get "pages/about"
  get "pages/contact"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  root "home#index"
end
