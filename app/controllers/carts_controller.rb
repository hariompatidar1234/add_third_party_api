class CartsController < ApplicationController
  before_action :set_cart
  load_and_authorize_resource

  def add_item
    add_cart = @current_user.cart.cart_items.build(cart_item_params)
    if add_cart.save
      render json: 'Item Added Successfully', status: 200
    else
      render json: add_cart.errors, status: :unprocessable_entity
    end
  end

  def update
    byebug
    @cart_item = @current_user.cart.cart_items.find_by_id(params[:cart_item_id])
    if @cart_item.update(cart_item_params)
      render json: 'Item Updated Successfully', status: 200
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @cart_item = @current_user.cart.cart_items.find_by_id(params[:id])
    if @cart_item.destroy
    render json: 'Item removed Successfully'
    end 
  end

  def clear_cart
    @current_user.cart.cart_items.destroya_all
    render json: @cart, include: :cart_items
  end

  def set_cart
    @cart = @current_user.create_cart unless @current_user.cart.present?
  end

  def cart_item_params
    params.permit(:dish_id,:quantity)
  end
end
