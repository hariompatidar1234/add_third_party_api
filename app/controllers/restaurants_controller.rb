class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show update destroy]
  load_and_authorize_resource

  def index
    page_number = params[:page]
    status = params[:status]

    restaurants = if status == 'open'
                    Restaurant.where(status: 'open').page(page_number).per(2)
                  elsif status == 'closed'
                    Restaurant.where(status: 'closed').page(page_number).per(2)
                  else
                    Restaurant.all.page(page_number).per(2)
                  end
    render json: restaurants
  end

  def show
    render json: @restaurant
  end

  def create
    restaurant = @current_user.restaurants.new(restaurant_params)
    if restaurant.save
      render json: restaurant, status: :created
    else
      render json: { errors: restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      render json: { data: @restaurant, message: 'Updated successfully' }
    else
      render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @restaurant.destroy
      render json: { data: @restaurant, message: 'Deleted successfully' }
    else
      render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def restaurant_params
    params.permit(:name, :status, :address, :picture)
  end

  def set_restaurant
    @restaurant = Restaurant.find_by_name(params[:restaurant_name])
  end
end
