Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  root 'home#index'

  resources :users, only: [:index, :show]
  resources :tenants do
    get :user_tenants, on: :collection
  end
  resources :members do
    get :invite, on: :collection
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
