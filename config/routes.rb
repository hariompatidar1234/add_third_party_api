Rails.application.routes.draw do
  resources :categories, param: :category_name, only: %i[index show create update] do
  end

  resources :restaurants, param: :restaurant_name, only: %i[index show create update destroy] do
    collection do
      get 'my_restaurants_list'
    end
  end
  
  resources :carts do
    member do
      delete 'destroy_all/', to: 'carts#destroy_all'
    end
  end

  resources :dishes do
    collection do
      get 'owner_dishes'
    end
  end

  resources :orders, only: %i[index show create] do
  end
  resources :users, only: [:index, :create]
  post 'users/login', to: 'users#login'
  # Define a resource for the current user
  resource :profile, controller: 'users', only: [:show, :update, :destroy], as: 'current_user_profile'

 
end
