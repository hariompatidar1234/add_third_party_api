Rails.application.routes.draw do
  resources :categories, param: :category_name, only: %i[index show create update] do
  end
  resources :restaurants, param: :restaurant_name, only: %i[index show create update destroy] do
  end
  resources :dishes, only: %i[index show create update destroy] do
  end

  resources :orders, only: %i[index show create destroy] do
  end
  
  resource :users
  post '/users_login', to: 'users#login'
  get '/all_users', to: 'users#index'

  resources :carts, param: :id, only: %i[destroy show create] do
  end
  delete 'orders/:id' => 'orders#destroy'
end
