Rails.application.routes.draw do
  resources :categories, param: :category_name, only: %i[index show create update] do
  end
  resources :restaurants, param: :restaurant_name, only: %i[index show create update destroy] do
    collection do
      get 'current_user_restaurants'
      get 'search_restaurant_by_name'
    end
  end
  resources :dishes, only: %i[index show create update destroy] do
  end

  resources :orders, only: %i[index show create destroy] do
  end

  resource :users
  post '/users_login', to: 'users#login'
  get '/all_users', to: 'users#index'

  resource :carts do
    delete '/cartitems/:id', to: 'carts#destroy_item'
  end
end
