Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  post 'task_status_update', to: 'tasks#status_update'
end
