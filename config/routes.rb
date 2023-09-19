Rails.application.routes.draw do
  resources :categories, param: :category_name, only: %i[index show create update destroy] do
  end

  resources :restaurants, param: :restaurant_name, only: %i[index show create update destroy] do
    collection do
      get 'my_restaurants_list'
    end
  end

  resources :carts 
  
      delete 'destroy_all/', to: 'carts#destroy_all'
  

  resources :dishes do
    collection do
      get 'owner_dishes'
    end
  end

  resources :orders, only: %i[index show create] do
  end
  resources :users, only: %i[index create]
  post 'users_login', to: 'users#login'

  resource :profile, controller: 'users', only: %i[show update destroy], as: 'current_user_profile'

  post 'users/forgot', to: 'users#forgot'
  post 'users/reset', to: 'users#reset'
  get 'restaurant_dish_list/:id', to: 'dishes#restaurant_dish_list'
end
