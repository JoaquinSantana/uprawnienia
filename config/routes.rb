Rails.application.routes.draw do
  
  get 'static_pages/pomoc'

  devise_for :users, controllers: {sessions: "sessions", users: "users"}

  concern :the_role, TheRole::AdminRoutes.new

  namespace :admin do
    concerns :the_role
  end

# :controllers => { :sessions => 'users/sessions' }
  
  resources :orders do
    collection do
      get 'wnioski'
    end
    member do
      patch 'zatwierdz'
      patch 'potwierdz'
    end
  end
  resources :order_items, only: [:create, :edit, :update, :destroy]
  resources :products
  resources :workers
  resources :branches

  root 'products#index'

  get '/pomoc', to: 'static_pages#pomoc'

end
