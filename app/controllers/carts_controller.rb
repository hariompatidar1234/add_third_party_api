class CartsController < ApplicationController
  load_and_authorize_resource

  def show
    @cart_data = @current_user.cart.cart_items.includes(:dish)
    cart_items_data = @cart_data.map do |cart_item|
      {
        id: cart_item.id,
        dish: cart_item.dish.name,
        price: cart_item.dish.price,
        quantity: cart_item.quantity
      }
    end

    total_amount = @cart_data.sum { |cart_item| cart_item.dish.price * cart_item.quantity }

    if cart_items_data.any?
      render json: { cart_items: cart_items_data, total_amount: total_amount }
    else 
      render json: { message: "Cart is Empty !!" }
    end
  end

  def create
    dish = Dish.find_by(id: cart_item_params[:dish_id])
  
    if dish.nil?
      render json: { error: 'Dish not found' }, status: :not_found
      return
    end
  
    cart_item = @current_user.cart.cart_items.new(cart_item_params)
  
    if cart_item.save
      render json: 'Item Added Successfully', status: :ok
    else
      render json: cart_item.errors, status: :unprocessable_entity
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
  
  private

  def cart_item_params
    params.permit(:dish_id, :quantity)
  end
end
