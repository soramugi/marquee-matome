Rails.application.routes.draw do
  root 'sites#index'

  get '/auth/:provider/callback', to: 'sessions#callback'
  get '/logout' => 'sessions#destroy', as: :logout

  resources :sites, only: [:index, :show, :new, :create, :destroy]

  get '/users/:name' => 'users#show', as: :user

  match '*a' => 'application#not_found', via: [:get, :post, :put, :delete]
end
