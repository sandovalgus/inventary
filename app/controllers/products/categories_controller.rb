class Products::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:edit, :update, :destroy]
  authorize_resource

  # GET /product/categories
  def index 
    @q = Category.ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @categories = @q.result.page(params[:page])
  end

  # GET /product/categories/new
  def new
    @category = Category.new
  end

  def edit; end

  # POST /product/categories
  def create
    @category = Category.new(category_params)
    if @category.save 
      redirect_to products_categories_path
    else
      render :new, alert: :error
    end
  end

  # PUT/PATCH /products/categories/1
  def update
    if @category.update(category_params)
      redirect_to products_categories_path
    else
      render :edit, alert: :error 
    end
  end

  # DELETE /products/categories/1
  def destroy 
    destroy_model(@category)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
