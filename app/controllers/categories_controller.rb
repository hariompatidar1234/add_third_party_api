class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show update]
  load_and_authorize_resource

  def index
    categories = Category.all
    render json: categories, status: :ok
  end

  def show
    render json: @category, status: :ok
  end

  def create
    @category = Category.new(category_params) # Load a new category
    if @category.save
      render json: { data: @category, message: 'Category Created' }, status: :created
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: { data: @category, message: 'Category Update  !!!' }, status: :ok
    else
      render json: { message: 'Category not found by Name' }, status: :not_found
    end
  end

  private

  def category_params
    params.permit(:name)
  end

  def set_category
    @category = Category.find_by_name(params[:category_name])
    render json: { error: 'Category not found by Name' }, status: :not_found unless @category
  end
end
