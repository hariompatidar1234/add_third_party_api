Rails.application.routes.draw do
  devise_for :users
  root to: "restaurants#index"


  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

   resource :profile, controller: 'users', as: 'current_user_profile'

  resources :categories do
    get 'category_dish', on: :collection
  end

  resources :restaurants  do
    get 'my_restaurants_list', on: :collection
  end

  # resources :restaurants
   resources :carts  do
    delete 'destroy_all', on: :collection
  end

  resources :dishes do
    collection do
      get 'owner_dishes'
      get 'filter', action: :index
    end
  end

  resources :orders
end
