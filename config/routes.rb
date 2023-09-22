Rails.application.routes.draw do
  resources :categories, param: :category_name, only: %i[index show create update destroy] do
  end

  resources :restaurants do
    collection do
      get 'my_restaurants_list'
    end
  end

  resources :carts

  delete 'destroy_all/', to: 'carts#destroy_all'

  resources :dishes do
    collection do
      get 'owner_dishes'
      get 'index/:restaurant_id', action: :index, on: :collection, as: 'restaurant_dish_list'
    end
  end

  resources :orders, only: %i[index show create] do
  end
  resources :users, only: %i[index create]
  post 'users_login', to: 'users#login'

  resource :profile, controller: 'users', only: %i[show update destroy], as: 'current_user_profile'

  post 'users_forgot_password', to: 'users#forgot_password'
  post 'users_reset_password', to: 'users#reset_password'
end
