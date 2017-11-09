Rails.application.routes.draw do

  root 'users#index'

  resources :users, except: [:destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :questions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
end
