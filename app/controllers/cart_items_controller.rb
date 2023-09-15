class CartItemsController < ApplicationController

    def show
        render json: @current_user.cart
    end
end
