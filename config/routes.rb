Rails.application.routes.draw do
  
  

  devise_for :users, controllers: {sessions: "sessions"}


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
  resources :roles
  resources :workers

  root 'roles#index'

end
