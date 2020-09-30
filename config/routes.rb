Rails.application.routes.draw do
  resource :sessions, only: %i[new] do
    get 'auth', on: :member
  end
  resources :builds, only: %i[new create] do
    scope module: :builds do
      resource :minimum_supported_version, only: :update
    end
  end
  resources :internal_builds, only: %i[index]
  resources :enqueues, only: %i[create]
  resources :devices, only: %i[index]
  resources :fetches, only: %i[create]
  resources :deploys, only: %i[destroy]
  root to: 'builds#index'

  namespace :api, defaults: { format: :json }, constraints: lambda { |req| req.format == :json } do
    resources :builds, only: %i[create]
    namespace :builds do
      resource :recommended_versions, only: :show, constraints: { format: 'json' }
    end
  end
end
