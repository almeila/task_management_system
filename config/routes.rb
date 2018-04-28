Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  post 'task_status_update', to: 'tasks#status_update'
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
  end

  get '*anything', to: 'errors#routing_error'
end
