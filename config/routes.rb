Rails.application.routes.draw do
  devise_for :users
  root to: "restaurants#index"


  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

   resource :profile, controller: 'users', as: 'current_user_profile'

  # resources :users do
  #   post 'login', on: :collection
  #   post 'forgot_password', on: :collection
  #   post 'reset_password', on: :collection
  # end


  resources :categories

  # resources :restaurants  do
  #   get 'my_restaurants_list', on: :collection
  # end

  resources :restaurants
   resources :carts, only: [:index, :show, :create, :update, :destroy] do
    delete 'destroy_all', on: :collection
  end

  resources :dishes do
    collection do
      get 'owner_dishes'
      get 'filter', action: :index
    end
  end

  resources :orders, only: [:index, :show, :create]
end






