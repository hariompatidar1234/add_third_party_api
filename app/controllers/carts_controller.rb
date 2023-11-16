class CartsController < ApplicationController
  # before_action :find_cart_item, only: %i[show update destroy]
  # before_action :cart_not_empty?, only: %i[index update show destroy]
  before_action :create_cart ,only: :create
  
  def index
  #   # @current_user.cart = Cart.all
  #   # @cart_item = CartItem.all
    @cart_items = current_user.cart.cart_items
  end
  
  # def create
  #   @dish = Dish.find_by_id(cart_item_params[:dish_id])
    
  #   unless @dish
  #     return render json: { error: 'Dish not found' }, status: :not_found
  #   end
    
  #   if @cart.cart_items.empty? || same_restaurant?(@cart, @dish.restaurant)
  #     @cart_item = @cart.cart_items.new(dish: @dish, quantity: cart_item_params[:quantity])
      
  #     if @cart_item.save
  #       render json: { message: 'CartItem added to cart successfully!', data: @cart_item }, status: :created
  #     else
  #       render json: { error: @cart_item.errors.full_messages }, status: :unprocessable_entity
  #     end
  #   else
  #     render json: { errors: 'CartItems could not be added to cart for a different restaurant' },
  #     status: :unprocessable_entity
  #   end
  # end
  
  # app/controllers/carts_controller.rb
# def create
#   @dish = Dish.find_by_id(cart_item_params[:dish_id])

#   unless @dish
#     return render json: { error: 'Dish not found' }, status: :not_found
#   end

#   if @cart.cart_items.empty? || same_restaurant?(@cart, @dish.restaurant)
#     @cart_item = @cart.cart_items.new(dish: @dish, quantity: cart_item_params[:quantity])

#     if @cart_item.save
#       respond_to do |format|
#         format.html { redirect_to new_cart_path, notice: 'CartItem added to cart successfully!' }
#         format.json { render partial: 'cart_item_partial', locals: { cart_item: @cart_item } }
#       end
#     else
#       respond_to do |format|
#         format.html { render :new }
#         format.json { render json: { error: @cart_item.errors.full_messages }, status: :unprocessable_entity }
#       end
#     end
#   else
#     respond_to do |format|
#       format.html { redirect_to new_cart_path, alert: 'CartItems could not be added to cart for a different restaurant' }
#       format.json { render json: { errors: 'CartItems could not be added to cart for a different restaurant' }, status: :unprocessable_entity }
#     end
#   end
# end

def create
  @dish = Dish.find_by_id(cart_item_params[:dish_id])

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


  # def show
  #   if @cart_item
  #     render json: @cart_item
  #   else
  #     render json: { error: 'Cart Item not found' }, status: :not_found
  #   end
  # end
  
  def show
    @cart_item = CartItem.find(params[:id])
  
    if @cart_item
      respond_to do |format|
        format.html # This will render the default show.html.erb template
        format.json { render json: @cart_item }
      end
    else
      respond_to do |format|
        format.html { redirect_to carts_path, alert: 'Cart Item not found' }
        format.json { render json: { error: 'Cart Item not found' }, status: :not_found }
      end
    end
  end
  
  # def update
  #   if @cart_item
  #     new_quantity = params[:quantity].to_i
  #     if new_quantity.positive?
  #       @cart_item.update(quantity: new_quantity)
  #       render json: { message: 'Cart Item quantity updated successfully', data: @cart_item }, status: :ok
  #     else
  #       render json: { error: 'Quantity must be greater than 0' }, status: :unprocessable_entity
  #     end
  #   else
  #     render json: { error: 'Cart Item not found' }, status: :not_found
  #   end
  # end

  def update
    if @cart_item
      new_quantity = params[:cart_item][:quantity].to_i
      if new_quantity.positive?
        @cart_item.update(quantity: new_quantity)
        redirect_to carts_path, notice: 'Cart Item quantity updated successfully!'
      else
        redirect_to edit_cart_path(@cart_item), alert: 'Quantity must be greater than 0'
      end
    else
      redirect_to carts_path, alert: 'Cart Item not found'
    end
  end
   
  
  # def destroy
  #   if @cart_item
  #     @cart_item.destroy
  #     render json: 'Cart Item Removed Successfully', status: :ok
  #   else
  #     render json: 'Cart Item not found', status: :not_found
  #   end
  # end

  def destroy
    @cart_item = CartItem.find(params[:id])
  
    if @cart_item
      @cart_item.destroy
      respond_to do |format|
        format.html { redirect_to carts_path, notice: 'Cart Item Removed Successfully' }
        format.json { render json: 'Cart Item Removed Successfully', status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to carts_path, alert: 'Cart Item not found' }
        format.json { render json: 'Cart Item not found', status: :not_found }
      end
    end
  end
  
  
  def destroy_all
    cart_items = current_user.cart.cart_items
    
    if cart_items.any?
      cart_items.destroy_all
      render json: 'All Cart Items Removed Successfully', status: :ok
    else
      render json: 'Cart is empty'
    end
  end
  
  private
  
  def cart_item_params
    params.permit(:quantity, :dish_id)
  end
  
  def same_restaurant?(cart, restaurant)
    cart.cart_items.empty? || cart.cart_items.first.dish.restaurant == restaurant
  end
  
  def find_cart_item
    @cart_item = current_user&.cart&.cart_items&.find_by_id(params[:id])
  end
  
  def cart_not_empty?
    if current_user&.cart&.cart_items&.empty?
      render json: { error: 'Cart is empty' }, status: :unprocessable_entity
    end
  end
  
  def create_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
