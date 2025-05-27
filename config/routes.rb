Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  root 'home#index'

  resources :users, only: [:index, :show] do
    member do # work on specific instance of the user resource
      patch :resend_invitation #/users/:id/resend_invitation
    end
  end
  resources :tenants do
    get :user_tenants, on: :collection
    member do
      patch :switch #find the current tenant_id
    end
  end
  resources :members do
    get :invite, on: :collection
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
