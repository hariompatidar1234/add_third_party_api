class OwnersController < ApplicationController
  def my_restaurants_list
    restaurants = Restaurant.where(user: @current_user)
    if restaurants.any?
      render json: restaurants
    else
      render json: { message: "You haven't added any restaurants yet." }, status: :ok
    end
  end

  def my_dishes_list

    dishes = Dish.joins(:restaurants).where("restaurants.user_id = #{@current_user.id}").filter_by_dish_name(params[:dish_name]).filter_by_category_name(params[:category_name]).page(params[:page])
    render json: dishes
  end
end
