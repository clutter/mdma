Rails.application.routes.draw do
  resources :builds do
    patch 'deploy', on: :member
  end
  resources :devices
  root to: 'application#index'
end
