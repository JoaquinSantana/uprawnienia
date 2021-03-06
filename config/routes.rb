Rails.application.routes.draw do
    
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
  resource :decisions
  end

  resources :order_items, only: [:show, :create, :edit, :update, :destroy] do
    resources :areas
  end

  resources :products
  resources :workers
  resources :branches


  get '/pomoc', to: 'static_pages#pomoc'
  get 'static_pages/pomoc'

  root 'products#index'
end
