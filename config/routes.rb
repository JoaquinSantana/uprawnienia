Rails.application.routes.draw do
  
  

  devise_for :users, controllers: {sessions: "sessions"}

  concern :the_role, TheRole::AdminRoutes.new

  namespace :admin do
    concerns :the_role
  end

#, :controllers => { :sessions => 'users/sessions' }
  
  resources :orders do
  	collection do
  		get 'wnioski'
  	end
    member do
      patch 'zatwierdz'
    end
  end
  resources :order_items, only: [:create, :edit, :update, :destroy]
  resources :products
  resources :workers

  root 'products#index'

end
