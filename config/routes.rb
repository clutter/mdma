Rails.application.routes.draw do
  resources :builds do
    patch 'deploy', on: :member
  end
  root to: 'application#index'
end
