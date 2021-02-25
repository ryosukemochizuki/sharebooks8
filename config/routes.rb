Rails.application.routes.draw do
  # static_pages
  root 'static_pages#home'
  get 'about',   to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
  # users
  resources :users, except: [:new]
  get 'signup', to: 'users#new'
  # sessions
  get 'login',     to: 'sessions#new'
  post 'login',    to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # actionposts
  resources :actionposts, except: [:new]
end
