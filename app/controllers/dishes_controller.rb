class DishesController < ApplicationController
  before_action :set_dish, only: %i[update destroy]
  load_and_authorize_resource

  def create
    restaurant = Restaurant.find_by_id(params[:restaurant_id])
    if restaurant && restaurant.user == @current_user
      @dish = restaurant.dishes.new(dish_params)
      if @dish.save
        render json: { message: 'Dish added successfully!', data: @dish }, status: :created
      else
        render json: { errors: @dish.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'You are not authorized to add a dish to this restaurant' }, status: :unauthorized
    end
  end

  def index
    page_number = params[:page]
    if params[:page].nil?
      render json: Dish.all
    else
      dishes = Dish.page(page_number).per(5)
      render json: dishes, status: :ok
    end
  end

  def update
    if @dish.update(dish_params)
      render json: { datd: @dish, message: 'Dish updated successfully!' }
    else
      render json: { message: 'Dish update failed' }
    end
  end

  def destroy
    if @dish.destroy
      render json: { data: @dish, message: 'Dish successfully deleted' }
    else
      render json: { message: 'Dish deletion failed' }
    end
  end

  def search_dishes_by_name
    name = params[:name]
    dishes = Dish.joins(:restaurants).where('name LIKE ?', "%#{name}%")
    render json: dishes
  end

  private

  def dish_params
    params.permit(:name, :price, :category_id, :restaurant_id, :picture)
  end

  def set_dish
    @dish = Dish.find_by_id(params[:id])
    render json: { message: 'Dish not found' }, status: :not_found unless @dish
  end
end
