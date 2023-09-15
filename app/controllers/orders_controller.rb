class OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :set_order, only: %i[show destroy]

  def index
    @orders = current_user.orders
    if @orders.any?
      render json: { orders: @orders }, status: :ok
    else
      render json: { message: 'No orders found' }, status: :not_found
    end
  end

  def show
    if @order
      render json: { order: @order, order_items: @order.order_items }, status: :ok
    else
      render json: { message: 'Order not found' }, status: :not_found
    end
  end

  def create
    @cart = current_user.cart
    if @cart.cart_items.empty?
      render json: { message: 'Cart is empty. Cannot create an order with an empty cart.' },
             status: :unprocessable_entity
    else
      @order = current_user.orders.new
      if @order.save
        create_order_items(@order)
        total_amount = @cart_items.sum { |cart_item| cart_item.dish.price * cart_item.quantity }
        render json: { total_amount: total_amount, data: @order, message: 'Order created successfully!' },
               status: :created
      else
        render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def create_order_items(order)
    cart_items = current_user.cart.cart_items.includes(:dish)
    cart_items.each do |cart_item|
      order_item = order.order_items.build(
        dish: cart_item.dish,
        quantity: cart_item.quantity
      )
      order_item.save
    end
    current_user.cart.cart_items.destroy_all
  end

  private

  def set_order
    @order = @current_user.orders.find(params[:id])
  end
end
