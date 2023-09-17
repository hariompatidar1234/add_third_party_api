# app/controllers/custom_application_controller.rb
class ApplicationController < ActionController::API
  rescue_from CanCan::AccessDenied do |exception|
    render json: exception.message
  end
  include JsonWebToken
  before_action :authenticate_request
  load_and_authorize_resource

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

  def render_404
    render json: { error: 'Invalid URL' }, status: :not_found
  end
end
