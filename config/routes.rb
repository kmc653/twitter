Rails.application.routes.draw do
  root to: 'users#index' 

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/timeline', to: 'users#timeline'

  resources :users, only: [:new, :create] do
    member do
      post 'follow'
      post 'unfollow'
    end
  end
  resources :statuses, only: [:new, :create]
  get "/:username", to: 'users#show', as: 'user'
end
