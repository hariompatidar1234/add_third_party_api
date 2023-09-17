class UsersController < ApplicationController
  before_action :authenticate_request, except: %i[create login]
 
  def index
    render json: User.all, status: :ok
  end

  def show
    render json: @current_user
  end

  def create
    user = User.new(user_params)

    if user.save
      # UserMailer.with(user: user).welcome_email.deliver_now
      render json: { data: user, message: 'User successfully created' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @current_user.update(user_params)
      render json: { data: @current_user, message: 'User updated' }
    else
      render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @current_user.destroy
      render json: { data: @current_user, message: 'User deleted' }, status: :no_content
    else
      render json: { message: 'User deletion failed' }
    end
  end

  def login
    user = User.find_by(email: params[:email], password: params[:password])

    if user
      token = jwt_encode(user_id: user.id)
      render json: { message: 'Logged In Successfully', token: token }
    else
      render json: { error: 'Please Check your Email and Password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :type)
  end
end
