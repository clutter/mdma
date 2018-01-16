Rails.application.routes.draw do
  resource :sessions, only: %i[new] do
    get 'auth', on: :member
  end
  resources :builds, only: %i[new create]
  resources :devices, only: %i[index]
  root to: 'builds#index'
end
