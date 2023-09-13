class OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :set_order, only: %i[show destroy]

  def index
    render json: @current_user.orders
  end

  def show
    order = @current_user.orders.find(params[:id])
    render json: order, state: 200
  end

  
  def destroy
    @order.destroy
    render json: 'Order deleted Successfully', status: 200
  end

  def create
    total_amount = calculate_total_amount

    order = @current_user.orders.new
    order.save

    if order.persisted?
      clear_cart
      render json: { message: 'Order Created Successfully', total_amount: total_amount }, status: :ok
    else
      render json: order.errors, status: :unprocessable_entity
    end
  end

  private

  def calculate_total_amount
    @current_user.cart.cart_items.sum { |cart_item| cart_item.dish.price * cart_item.quantity }
  end

  def clear_cart
    @current_user.cart.cart_items.destroy_all
  end

  def set_order
    @order = @current_user.orders.find(params[:id])
  end
end
