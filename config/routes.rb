Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resource :profiles
  end
  root 'welcome#index'
end
