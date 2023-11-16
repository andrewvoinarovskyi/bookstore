Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resources :books, only: [:index, :show] do
    member do
      post 'purchase'
    end
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :orders, only: [:index]

  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new', as: 'login_page'
  post '/login', to: 'sessions#create', as: 'login'
  delete '/logout', to: 'sessions#destroy'

  root 'books#index'
end
