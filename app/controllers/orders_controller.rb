class OrdersController < ApplicationController
  # before_action :find_order, only: [:show]
  before_action :set_order, only: [:create_payment]
  def index
    # @orders_ = current_user.orders
    # order = current_user.orders
    @order = current_user.orders
    # @order_items = order.order_items
    # render json: @orders, status: :ok
  end

  def new
    @order = Order.new
  end

  def create
    @cart = current_user.cart
    if @cart.cart_items.empty?
      flash[:alert] = 'Cart is empty. Cannot create an order with an empty cart.'
      redirect_to root_path
    else
      @order = current_user.orders.new(address: params[:address])

      if @order.save
        # OrderMailer.order_confirm(current_user).deliver_now
         # OrderMailer.notify_owner(order.id, owner_email).deliver_later
          flash[:notice] = 'Order created successfully!'
          redirect_to orders_path
      else
        flash[:error] = @order.errors.full_messages.join(', ')
        render 'new' # Render the new order form again
      end
    end
  end


 def create_order_items(order)
  cart_items.each do |cart_item|
     order_item = order.order_items.new(
       dish_id: cart_item.dish.id,
       quantity: cart_item.quantity,
       total_amount: cart_item.quantity * cart_item.dish.price
     )
     order_item.save
   # current_user.cart.cart_items.destroy_all
   end
 end

  def create_payment
    byebug
    if @order.update(razorpay_payment_id: params[:razorpay_payment_id], payment_status: "payment_confirmed")
      # current_user.cart.cart_item.destroy  # destroy_cart_item
      redirect_to create_payment_order_path(@order)
    else
      render :payment
    end
  end


  def show
    @order = Order.find_by_id(params[:id])
    @order_items = @order.order_items
    # render json: @orders, status: :ok
  end

  private

  # def find_order
  #   @order = current_user&.orders&.find_by_id(params[:id])
  #   render json: { error: 'Order not found' }, status: :not_found unless @order
  # end


  def set_order
    @order = Order.find(params[:id])
  end
end
