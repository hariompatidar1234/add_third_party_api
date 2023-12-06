class CartsController < ApplicationController
  # before_action :find_cart_item, only: %i[show update destroy]
  before_action :cart_not_empty?, only: :index
  before_action :create_cart ,only: %i[show, index]


  def index
    @cart_items = current_user.cart.cart_items
  end


  def create
    @dish = Dish.find_by_id(cart_item_params[:dish_id])
    @cart = current_user.cart || current_user.create_cart

    unless @dish
      flash[:alert] = 'Error: Dish not found'
      return redirect_to new_cart_path
    end

    if @cart.cart_items.empty? || same_restaurant?(@cart, @dish.restaurant)
      @cart_item = @cart.cart_items.new(dish: @dish, quantity: cart_item_params[:quantity])

      if @cart_item.save
        flash[:notice] = 'CartItem added to cart successfully!'
      else
        flash[:alert] = 'Error: CartItem could not be added to cart.'
      end
    else
      flash[:alert] = 'Error: CartItems could not be added to cart for a different restaurant.'
    end
    redirect_to new_cart_path
  end

  def show
    @cart_item = CartItem.find(params[:id])
  end

  def edit
    @cart_item = CartItem.find_by_id(params[:id])
  end

  def update
    @cart_item = current_user&.cart&.cart_items&.find_by_id(params[:id])
    if @cart_item
      new_quantity = params[:cart_item][:quantity].to_i
      if new_quantity.positive?
        @cart_item.update(quantity: new_quantity)
        redirect_to carts_path, notice: 'Cart Item quantity updated successfully!'
      else
        redirect_to edit_cart_path(@cart_item), alert: 'Quantity must be greater than 0', status: :unprocessable_entity
      end
    end
  end

  def destroy
    byebug
    @cart_item = current_user&.cart&.cart_items&.find_by_id(params[:id])
      @cart_item.destroy
      redirect_to carts_path
      flash[:notice] ='Cart Item Removed Successfully'
  end

  private

  def cart_item_params
    params.permit(:quantity, :dish_id)
  end

  def same_restaurant?(cart, restaurant)
    cart.cart_items.empty? || cart.cart_items.first.dish.restaurant == restaurant
  end

  # def find_cart_item
  #   @cart_item = current_user&.cart&.cart_items&.find_by_id(params[:id])
  # end

  def cart_not_empty?
    if current_user&.cart&.cart_items&.empty?
      # render json: { error: 'Cart is empty' }, status: :unprocessable_entity
      return redirect_to new_cart_path, notice: 'Cart is Empty'

    end
  end

  def create_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
