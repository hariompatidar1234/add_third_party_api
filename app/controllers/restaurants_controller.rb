class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show update destroy]

  def index
    restaurants = Restaurant.all
    @restaurants = if params[:name]
                    restaurants.where('name LIKE ?', "%#{params[:name]}%")
                  elsif params[:status]
                    restaurants.where(status: params[:status])
                  elsif params[:address]
                    restaurants.where('address LIKE ?', "%#{params[:address]}%")
                  else
                    restaurants.page(params[:page]).per(10)
                  end
    # render json: @restaurants
  end


  def new
    @restaurant = Restaurant.new
  end

  def create
    restaurant = current_user.restaurants.new(restaurant_params)
    if restaurant.save
     flash[:message] = "You Created Successfully!"
      redirect_to root_path
    else
      render json: { error: restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end



  def show
    @restaurant = Restaurant.find_by_id(params[:id])
  end

  def update
    if @restaurant.owner == current_user
      if @restaurant.update(restaurant_params)
       flash[:success] = 'Restaurant updated successfully'
       redirect_to restaurant_path(@restaurant)
      else
        flash[:error] = @restaurant.errors.full_messages.join(', ')
        render :edit
      end
    else
      render json: { error: 'You are not authorized to update this restaurant' }, status: :unauthorized
    end
  end

  def edit
    @restaurant = Restaurant.find_by_id(params[:id])
  end


  def destroy
    if @restaurant.owner == current_user
      if @restaurant.destroy
        render json: { data: @restaurant, message: 'Restaurant deleted successfully' }
      else
        render json: { error: @restaurant.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'You are not authorized to delete this restaurant' }, status: :unauthorized
    end
  end

  def my_restaurants_list
    restaurants = @current_user.restaurants
    if restaurants.any?
      render json: restaurants
    else
      render json: { error: "You haven't added any restaurants yet." }, status: :ok
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :status, :address, :picture)
  end

  def set_restaurant
    @restaurant = Restaurant.find_by_id(params[:id])
    render json: { error: 'Restaurant not found' }, status: :not_found unless @restaurant
  end
end
