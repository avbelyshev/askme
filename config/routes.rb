Rails.application.routes.draw do

  root 'users#index'

  resources :users #, except: [:destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :questions, except: [:show, :new, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
