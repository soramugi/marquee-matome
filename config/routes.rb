Rails.application.routes.draw do
  root 'sites#index'

  get '/auth/:provider/callback', to: 'sessions#callback'
  get '/logout' => 'sessions#destroy', as: :logout

  resources :sites, only: [:index, :show, :new, :create, :destroy]

end
