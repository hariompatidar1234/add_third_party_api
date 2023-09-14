class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show update destroy]
  before_action :authenticate_request
  load_and_authorize_resource

  def index
    page_number = params[:page]
    if params[:status] == 'open'
      restaurants = Restaurant.where(status: 'open')
      render json: restaurants
    else
      restaurant = Restaurant.all.page(page_number).per(5)
      render json: restaurant
    end
  end

  def current_user_restaurants
    restaurant = Restaurant.where(user: @current_user)
    if restaurants.any?
      render json: restaurants
    else
      render json: { message: "You haven't added any restaurants yet." }, status: :ok
    end
  end

  def show
    render json: @restaurant
  end

  def create
    restaurant = @current_user.restaurants.new(restaurant_params)
    if restaurant.save
      render json: { data: restaurant, message: 'Restaurant added successfully' }, status: :created
    else
      render json: { errors: restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @restaurant.user == @current_user # Check if the current user owns the restaurant
      if @restaurant.update(restaurant_params)
        render json: { data: @restaurant, message: 'Updated successfully' }
      else
        render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'You are not authorized to update this restaurant' }, status: :unauthorized
    end
  end

  def destroy
    if @restaurant.user == @current_user # Check if the current user owns the restaurant
      if @restaurant.destroy
        render json: { data: @restaurant, message: 'Deleted successfully' }
      else
        render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'You are not authorized to delete this restaurant' }, status: :unauthorized
    end
  end

  def search_restaurant_by_name
    name = params[:name]
    restaurant = Restaurant.where('name LIKE ?', "%#{name}%")
    render json: restaurant, status: :ok
  end

  private

  def restaurant_params
    params.permit(:name, :status, :address, :picture)
  end

  def set_restaurant
    @restaurant = Restaurant.find_by_name(params[:restaurant_name])
  end
end
