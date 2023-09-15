class DishesController < ApplicationController
  before_action :set_dish, only: %i[update destroy,show]
  load_and_authorize_resource

  def index
    dishes = Dish.all
    dishes = if params[:name]
              dishes.joins(:restaurants).where('name LIKE ?', "%#{name}%")
              else 
                dishes.page(params[:page]).per(5)
              end 
    render json: dishes 
  end
  
  def show 
    render json: @dish
  end 

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

  private

  def dish_params
    params.permit(:name, :price, :category_id, :restaurant_id, :picture)
  end

  def set_dish
    @dish = Dish.find_by_id(params[:id])
    render json: { message: 'Dish not found' }, status: :not_found unless @dish
  end
end
