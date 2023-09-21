class UsersController < ApplicationController
  before_action :authenticate_request, except: %i[create login forgot reset]

  def index
    render json: User.all, status: :ok
  end

  def show
    render json: @current_user
  end

  def create
    user = User.new(user_params)

    if user.save
      UserMailer.with(user: user).welcome_email.deliver_now
      render json: user , status: :created
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

  def forgot
    return render json: 'mail n bmust be pass' unless params[:email]

    user = User.find_by_email(params[:email])
    if user.present?
      user.generate_password_token! # generate pass token
      UserMailer.with(user: user).forgot_password_token.deliver_now
      render json: 'Email Send Successfully'
    else
      render json: { error: ['Username not found. Please check and try again.'] }, status: :not_found
    end
  end

  def reset
    token = params[:token]

    return render json: { error: 'Token not present' } unless token

    user = User.find_by(reset_password_token: token)

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: 'Password Update Successfully'
      else
        render status: :unprocessable_entity, json: { error: user.errors.full_messages }
      end
    else
      render status: :not_found, json: { error: ['Link not valid or expired. Try generating a new link.'] }
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :type)
  end
end
