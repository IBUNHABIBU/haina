Rails.application.routes.draw do
  resources :tatizos
  resources :tv_sizes
  resources :tv_brands
  resources :customers
  resources :activities do
    resources :repair_returns, except: :index
  end
  resources :spares do
    resources :spare_purchases, only: %i[index new create]
  end
  resources :spare_categories, except: :show
  resources :expenses

  get "/dashboard", to: "dashboard#index", as: :dashboard

  devise_for :users, path: "", path_names: {
    sign_up: "adminregister",
    sign_in: "login",
    sign_out: "logout"
  }

  resources :users, only: %i[index update destroy]
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"
end
