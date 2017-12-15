Rails.application.routes.draw do
  resource :sessions, only: %i[new] do
    get 'auth', on: :member
  end
  resources :builds do
    patch 'deploy', on: :member
  end
  resources :devices
  root to: 'builds#index'
end
