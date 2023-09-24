Rails.application.routes.draw do
  resources :categories, param: :category_name, only: %i[index show create update destroy] do
  end

  resources :restaurants do
    collection do
      get 'my_restaurants_list'
    end
  end

  # resources :carts

  # delete 'destroy_all/', to: 'carts#destroy_all'

  
  resources :carts do
    delete 'destroy_all', on: :collection
  end

  # resources :dishes do
  #   collection do
  #     get 'owner_dishes'
  #     get 'index/:restaurant_id', action: :index, on: :collection, as: 'restaurant_dish_list'
  #   end
  # end


  resources :dishes, only: [:index] do
    collection do
      get 'owner_dishes'
      get 'filter', action: :index
    end
  end
  # To filter by restaurant_id, use /dishes/  
  # To filter by name, use /dishes/filter?name=YourDishName.
  # To filter by category_id, use /dishes/filter?category_id=2.

  resources :orders, only: %i[index show create] do
  end
  resources :users, only: %i[index create]
  post 'users_login', to: 'users#login'

  resource :profile, controller: 'users', only: %i[show update destroy], as: 'current_user_profile'

  post 'users_forgot_password', to: 'users#forgot_password'
  post 'users_reset_password', to: 'users#reset_password'
end



 


