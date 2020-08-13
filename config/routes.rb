Rails.application.routes.draw do

  resources :users, only: [:new, :create]

  resources :ideas

  get 'user/ideas', to: 'ideas#user_ideas'

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  get 'search/ideas', to: 'ideas#search'

  get 'welcome', to: 'sessions#welcome'

  get 'authorized', to: 'sessions#page_requires_login'

  get 'logout', to: 'sessions#destroy'


  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/login'
  # get 'sessions/welcome'
  # get 'users/new'
  # get 'users/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sessions#welcome'
  
end
