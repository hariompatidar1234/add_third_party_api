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
    render json: cart_items_data
  end

  def create
    cart_item = @current_user.cart.cart_items.new(cart_item_params)
    if cart_item.save
      render json: 'Item Added Successfully', status: 200
    else
      render json: cart_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    cart_item = @current_user.cart.cart_items.find(params[:id])
    if cart_item
      cart_item.destroy
      render json: 'Cart Item Removed Successfully', status: :ok
    else
      render json: 'Deletion Failed'
    end
  end

  private

  def cart_item_params
    params.permit(:dish_id, :quantity)
  end
end
