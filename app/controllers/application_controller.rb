# app/controllers/custom_application_controller.rb

class ApplicationController < ActionController::API
  include JsonWebToken
  before_action :authenticate_request, except: :create

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
