Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resources :statuses, only: [:new, :create]
  get "/:username", to: 'users#show', as: 'user'
end
