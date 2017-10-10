Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'landing#index'

  get 'login', to: 'sessions#new'

  get 'logout', to: 'sessions#destroy'

  resource :user do
    resources :projects
  end

  get 'auth/github/callback' => 'sessions#create'

  get 'auth/trello/callback' => 'sessions#trello_callback'

  get 'auth/github', as: 'github_login'

  get 'auth/trello', as: 'trello_login'

  get 'get_graph' => 'landing#graph', as: 'graph'

end
