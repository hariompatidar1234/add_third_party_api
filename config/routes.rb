Rails.application.routes.draw do
  resources :categories,param: :category_name,only:  [:index, :show, :create,:update] do
  end
  resources :restaurants, param: :restaurant_name, only: [:index, :show, :create, :update, :destroy] do
  end
  resources :dishes, only: [:index, :show, :create, :update, :destroy] do
  end

  resources :orders, only: [:index, :show, :create,:destroy] do
  end
  get 'restaurants/open', to: 'restaurants#open_restaurants'
  resource :users
  post '/users_login', to: 'users#login'

  resources :carts

end
