Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
  get 'pages/help'
  get 'pages/link'
  resources :users do
    member do
      resources :follows, only:[:create]
      get '/followings', to: 'follows#followings'
      get '/followers', to: 'follows#followers'
    end
  end
  
  resources :follows, only:[:destroy]
  # resources :topics
  # resources :comments
  resources :profiles

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  get 'favorites/index'
  post '/favorites', to: 'favorites#create'
  delete '/favorites', to: 'favorites#destroy'
  
  resources :topics do
    member do
      resources :comments, only: [:new, :create]
      get 'favorite_users', to: 'favorites#favorite_users'
    end
  end
  
  get '/favorite_ranking', to: 'favorites#ranking'
end