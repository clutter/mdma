Rails.application.routes.draw do
  resource :sessions, only: %i[new] do
    get 'auth', on: :member
  end
  resources :builds, only: %i[new create]
  resources :enqueues, only: %i[create]
  resources :devices, only: %i[index update]
  resources :timeslots, only: %i[index show]
  resources :fetches, only: %i[create]
  root to: 'builds#index'
end
