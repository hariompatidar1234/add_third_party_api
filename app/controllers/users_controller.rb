class UsersController < ApplicationController
  before_action :authenticate_request, except: %i[create login]
  
  def show
    render json: @current_user
  end

  def create
    user = User.new(user_param)
    if user.save
      render json: { data: user, message: 'successfully created' }
    else
      render json: { error: 'User Registration failed' }
    end
  end

  def update
    if @current_user.update(user_param)
      render json: {data: @current_user,  message: 'User updated' }
    else
      render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @current_user.destroy
      render json: {data: @current_user, message: 'User deleted' }, status: :no_content
    else
      render json: { message: ' deletion failed' }
    end
  end

  def login
    if user = User.find_by(email: params[:email], password: params[:password])
      token = jwt_encode(user_id: user.id)
      render json: { message: 'Logged In Successfully..', token: token }
    else
      render json: { error: 'Please Check your Email And Password.....' }
    end
  end

  private
  def user_param
    params.permit(%i[name email password type])
  end

end
