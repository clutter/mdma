Rails.application.routes.draw do
  resource :sessions, only: %i[new] do
    get 'auth', on: :member
  end
  resources :builds, only: %i[new create]
  resources :devices, only: %i[index]
  resources :timeslots, only: %i[index]
  resources :fetches, only: %i[create]
  root to: 'builds#index'
end
