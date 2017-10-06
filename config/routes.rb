Rails.application.routes.draw do

  # devise_for :controllers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'landing#index'

  get 'login', to: 'sessions#new', as: 'new_user_session'

  post 'login', to: 'sessions#create'

  resources :users, except: :index

  # get '/auth/trello/callback' => 'sessions#create'

  # get '/auth/github/callback' => 'users#show'

  devise_for :users

  # get '/auth/github' => 'users#show'

end

