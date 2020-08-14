Rails.application.routes.draw do

  resources :users, only: [:new, :create]

  resources :ideas

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  get 'search/ideas', to: 'ideas#search'

  get 'welcome', to: 'sessions#welcome'

  get 'authorized', to: 'sessions#page_requires_login'

  get 'logout', to: 'sessions#destroy'

  resources :passwords, only: [:new, :create, :edit, :update]

  root 'sessions#welcome'
  
end
