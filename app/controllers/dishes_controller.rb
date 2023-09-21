class DishesController < ApplicationController
  before_action :set_dish, only: %i[show update destroy]

  def index
    dishes = Dish.all
    dishes = if params[:name]
               dishes.where('name LIKE ?', "%#{params[:name]}%")
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

    if restaurant && restaurant.owner == @current_user
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
    return unless dish_authorization_check

    if @dish.update(dish_params)
      render json: { data: @dish, message: 'Dish updated successfully!' }
    else
      render json: { errors: @dish.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    return unless dish_authorization_check

    if @dish.destroy
      render json: { data: @dish, message: 'Dish successfully deleted' }
    else
      render json: { errors: 'Dish deletion failed' }
    end
  end

  def owner_dishes
    owner_dishes = @current_user.restaurants.map { |restaurant| restaurant.dishes }.flatten
    if params[:name].present?
      owner_dishes = owner_dishes.select { |dish| dish.name.downcase.include?(params[:name].downcase) }
    end
    if params[:category_id].present?
      owner_dishes = owner_dishes.select { |dish| dish.category_id == params[:category_id].to_i }
    end

    render json: owner_dishes
  end

  def restaurant_dish_list
    restaurant = Restaurant.find_by_id(params[:id])
    dishes = restaurant.dishes
    dishes = if params[:category_id]
               dishes.where(category_id: "#{params[:category_id]}")
             elsif params[:name]
               dishes.where('name LIKE ?', "%#{params[:name]}%")
             end
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

  def dish_authorization_check
    return true if @dish.restaurant.owner == @current_user

    render json: { error: 'You are not authorized to perform this action on this dish' }, status: :unauthorized
    false
  end
end

  # def show
  #   dishes = @restaurant.dishes
  #   dishes = if params[:category_id]
  #             dishes.where(category_id: "#{params[:category_id]}")
  #           elsif params[:name]
  #             @restaurant.dishes.where('name LIKE ?', "%#{params[:name]}%")
  #           end

  #   render json: dishes.any? ? dishes : @restaurant
  # end
