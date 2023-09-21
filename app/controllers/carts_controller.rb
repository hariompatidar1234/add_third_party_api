class CartsController < ApplicationController

  def index
   render json: @current_user.cart
  end 

  def show
    cart_item = @current_user.cart.cart_items.find_by_id(params[:id])

    if cart_item
      render json: {
        id: cart_item.id,
        dish_id: cart_item.dish.id,
        dish_name: cart_item.dish.name,
        dish_price: cart_item.dish.price,
        quantity: cart_item.quantity,
        total_amounts: cart_item.total_amounts
      }
    else
      render json: { errors: 'Cart Item not found' }, status: :not_found
    end
  end

  def create
    @cart = @current_user.cart || @current_user.create_cart
    @dish = Dish.find_by_id(cart_item_params[:dish_id])
  
    if @dish
      if @cart.cart_items.empty? || same_restaurant?(@cart, @dish.restaurant)
        @cart_item = @cart.cart_items.new(dish: @dish, quantity: cart_item_params[:quantity])
       
        if @cart_item.save
          render json: { message: 'CartItem added to cart successfully!', data: @cart_item }, status: :created
        else
          render json: { errors: @cart_item.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: 'CartItems could not be added to cart for a different restaurant' },
               status: :unprocessable_entity
      end
    else
      render json: { errors: 'Dish not found' }, status: :not_found
    end
  end

  def update
    cart_item = @current_user.cart.cart_items.find_by_id(params[:id])
  
    if cart_item
      new_quantity = params[:quantity]
  
      if new_quantity > 0
        cart_item.update(quantity: new_quantity)
        render json: { message: 'Cart Item quantity updated successfully', data: cart_item }, status: :ok
      else
        render json: { errors: 'Quantity must be greater than 0' }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'Cart Item not found' }, status: :not_found
    end
  end
   
  def destroy
    cart_item = @current_user.cart.cart_items.find_by_id(params[:id])

    if cart_item
      cart_item.destroy
      render json: 'Cart Item Removed Successfully', status: :ok
    else
      render json: 'Cart Item not found', status: :not_found
    end
  end

  def destroy_all
    if @current_user.cart.cart_items.any?
      @current_user.cart.cart_items.destroy_all
      render json: 'All Cart Items Removed Successfully', status: :ok
    else
      render json: 'cart is empty'
    end
  end

  private
   
  def cart_item_params
      params.permit(:quantity, :dish_id)
  end 

  def same_restaurant?(cart, restaurant)
    cart.cart_items.empty? || cart.cart_items.first.dish.restaurant == restaurant
  end

end
