Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'landing#index'

  resource :user do
    resources :projects
  end

  get 'logout', to: 'sessions#destroy'

  post 'user/projects' => 'projects#create', as: 'projects'

  get 'auth/github/callback' => 'sessions#create'

  get 'auth/trello/callback' => 'users#trello_callback'

  get 'auth/github', as: 'login'

  get 'auth/trello', as: 'trello_login'

  get '/user/step2' => 'users#step_two', as: 'users_step_two'

  get '/add_collabs/:id' => 'projects#new_collaborators', as: 'add_collabs'

  post '/add_collabs/:id' => 'projects#add_collaborators'

  get 'user/search' => 'users#search'

  get 'user/projects/:id' => 'projects#add_repo', as: 'add_repo'

  post 'user/projects/:id' => 'projects#add_repo'

  get 'projects' => 'projects#nav_index', as: 'nav_project_index'

end
