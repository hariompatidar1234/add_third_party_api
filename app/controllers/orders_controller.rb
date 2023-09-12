class OrdersController < ApplicationController
    load_and_authorize_resource
    before_action :set_order, only: [:show,:destroy]

    def index
      orders = @current_user.orders.includes(:order_items)
      return  render json: orders unless orders.empty?
      render json: 'No Orders yet'
    end

    def show
    order = @current_user.orders.find(params[:id])
    render json: order, state:200
    end

    def create
    order = @current_user.orders.new
    order.save
    @current_user.cart.cart_items.each do |cart_item|
        order.order_items.create(
        dish_id: cart_item.dish_id,
        # quantity: cart_item.quantity
        )
    end
    @current_user.cart.cart_items.destroy_all

    render json: 'Order Created Successfully', status: :ok
    end

    def destroy
    @order.destroy
    render json: "Order deleted Successfully", status:200
    end

    private
    def set_order
    @order = @current_user.orders.find(params[:id])
    end

end 
