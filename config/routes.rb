Rails.application.routes.draw do

  root 'static_pages#home'
  get 'static_pages/help'
  get 'sessions/new'


  get "/about", to: 'static_pages#about'
  get "/contact", to: 'static_pages#contact'
  get "/help", to: 'static_pages#help'


  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/search', to: 'questions#search'

  post '/upvote', to: 'votes#up_vote'
  post '/downvote', to: 'votes#down_vote'

  resources :users
  resources :account_activations , only: [:edit]
  resources :password_resets , only:[:new, :create, :edit, :update]
  resources :questions , except: [:create]

  resources :answers ,except: [:index,:show]
  resources :tags, only: [:index, :show]
  resources :comments, except: [:new, :index, :show]
end

