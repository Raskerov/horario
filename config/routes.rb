Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :company_users
      resources :companies

      root to: "users#index"
    end

  devise_for :users
  root to: 'app/application#index'
  get '/app/(*vue)', to: 'app/application#index', as: :vue_app
end
