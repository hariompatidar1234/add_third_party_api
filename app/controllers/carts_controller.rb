class CartsController < ApplicationController
  load_and_authorize_resource

  def show
    @cart = @current_user.cart
    @cart_items = @cart.cart_items.includes(:dish)

    if @cart_items.any?
      cart_items_data = @cart_items.map do |cart_item|
        {
          id: cart_item.id,
          dish_id: cart_item.dish.id,
          dish_name: cart_item.dish.name,
          quantity: cart_item.quantity
        }
      end

      total_amount = @cart_items.sum { |cart_item| cart_item.dish.price * cart_item.quantity }
      render json: { cart_items: cart_items_data, total_amount: total_amount }
    else
      render json: { message: 'Cart is Empty!' }, status: :ok
    end
  end

  def create
    @cart = current_user.cart
    @dish = Dish.find_by_id(cart_item_params[:dish_id])

    if @dish
      if same_restaurant?(@cart, @dish.restaurant)
        cart_item = @cart.cart_items.new(cart_item_params)
        if cart_item.save
          render json: { message: 'CartItem added to cart successfully!', data: cart_item }, status: :created
        else
          render json: { errors: cart_item.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: 'CartItems could not be added to cart for different restaurant' },
               status: :unprocessable_entity
      end
    else
      render json: { errors: 'Dish not found' }, status: :not_found
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

  def destroy_all_items
    @current_user.cart.cart_items.destroy_all
    render json: 'All Cart Items Removed Successfully', status: :ok
  end

  private

  def cart_item_params
    params.permit(:dish_id, :quantity)
  end

  def same_restaurant?(cart, restaurant)
    cart.cart_items.empty? || cart.cart_items.first.dish.restaurant == restaurant
  end
end
