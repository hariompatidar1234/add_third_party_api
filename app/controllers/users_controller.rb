class UsersController < ApplicationController
  before_action :authenticate_request, except: :create
  def create
    user = User.new(user_param)
    if user.save
      render json: { data: user, message: 'successfully created' }
    else
      render json: { error: 'User Registration failed' }
    end
  end

  def show
    render json: @current_user
  end

  def update
    if @current_user.update(user_params)
      render json: { message: 'User updated' }
    else
      render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @current_user.destroy
      render json: { message: 'User deleted' }, status: :no_content
    else
      render json: { message: ' deletion failed' }
    end
  end

  def user_param
    params.permit(%i[name email password type])
  end
end
