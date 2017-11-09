Rails.application.routes.draw do

  root 'users#index'

  resources :users, except: [:destroy]
  resources :questions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
