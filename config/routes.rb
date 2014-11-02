Rails.application.routes.draw do
  root to: 'users#index' 

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create]
  resources :statuses, only: [:new, :create]
  get "/:username", to: 'users#show', as: 'user'
end
