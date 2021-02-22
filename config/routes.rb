Rails.application.routes.draw do
  root 'static_pages#home'
  get 'about',   to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
  resources :users, except: [:new]
  get 'signup', to: 'users#new'
end
