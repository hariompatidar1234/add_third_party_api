# app/controllers/custom_application_controller.rb
class ApplicationController < ActionController::API
  include JsonWebToken
  before_action :authenticate_request
  authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    render json: exception.message
  end

  rescue_from ActiveRecord::RecordNotFound, with: :handle_exception
  rescue_from NoMethodError, with: :handle_pram_exception

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = jwt_decode(header)
    @current_user = User.find(decoded[:user_id])
  rescue JWT::DecodeError => e
    render json: { error: 'Invalid token' }, status: :unprocessable_entity
  rescue ActiveRecord::RecordNotFound
    render json: 'No record found..'
  end

  attr_reader :current_user

  def handle_exception
    render json: { error: 'Invalid Id ' }, status: 404
  end

  def handle_pram_exception
    render json: {error: 'Param is missing or Empty Value'}, status:406
  end
end
