Rails.application.routes.draw do
  root to: 'app/application#index'
  get '/app/(*vue)', to: 'app/application#index', as: :vue_app
end
