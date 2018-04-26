Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resource :profile
  end

  get '/forbidden', to: 'welcome#index'

  get 'admin', to: 'admin#index'
  get '/admin/users', to: 'admin#users', as: 'user_management'
  get '/admin/toggleadmin/:id', to: 'admin#toggle_admin', as: 'toggle_admin'

  root 'welcome#index'
  match '*path', to: redirect('/'), via: :all
end
