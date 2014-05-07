Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/:provider/callback', to: 'sessions#callback'
  get '/logout' => 'sessions#destroy', as: :logout
end
