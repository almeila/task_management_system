Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  post 'task_status_update', to: 'tasks#status_update'

  resources :users
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
