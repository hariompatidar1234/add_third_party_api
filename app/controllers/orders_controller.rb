class OrdersController < ApplicationController
  before_action :set_dish, only: %i[update destroy]
  load_and_authorize_resource

  def index
    orders = @current_user.orders.includes(:order_items)
    render json: @orders
  end

  def show
    order = @current_user.orders.find(params[:id])
    render json: order, state: 200
  end

  def create
    @order = current_user.orders.build(status: 'ordered')

    if @order.save
      @cart.cart_items.each do |cart_item|
        @order.order_items.create(
          dish: cart_item.dish,
          quantity: cart_item.quantity
        )
        @order.order_amount += order_item.dish.price * order_item.quantity
      end

      # Empty the cart
      @cart.cart_items.destroy_all

      render json: @order, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @order = current_user.orders.find(params[:id])
    @order.destroy
    render json: 'Order deleted successfully', status: :ok
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart(status: 'cart')
  end
end
