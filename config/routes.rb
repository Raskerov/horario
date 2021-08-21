Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :company_users
      resources :companies

      root to: "users#index"
    end

  devise_for :users, skip: :all
  devise_scope :user do
    scope :api do
      scope :auth do
        post :sign_in, to: 'api/auth/sessions#create'
        delete :sign_out, to: 'api/auth/sessions#destroy'
        post :sign_up, to: 'api/auth/registrations#create'
        post :update, to: 'api/auth/registrations#update'
        post :password, to: 'api/auth/passwords#create'
        put :password, to: 'api/auth/passwords#update'
      end
    end
  end

  namespace :api do
    resource :user, only: [:show, :update]
  end

  root to: 'app/application#index'

  get '/app/(*vue)', to: 'app/application#index', as: :vue_app
  get '/auth/(*vue)', to: 'app/application#auth', as: :vue_auth
end
