Rails.application.routes.draw do
  resources :builds
  root to: 'application#index'
end
