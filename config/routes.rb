Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  post 'task_status_update', to: 'tasks#status_update'
  post 'add_label', to: 'tasks#add_label'
  post 'remove_label', to: 'tasks#remove_label'

  resources :labels  
  resources :users
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  namespace :admin do
    get '/', to: 'home#index'
    resources :users do
      resources :tasks, only: [:index]
    end
    resources :labels, only: [:index, :delete]
  end

  get '*anything', to: 'errors#routing_error'
end
