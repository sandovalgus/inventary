class Products::FamiliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_family, only: [:edit, :update, :destroy]
  authorize_resource

  # GET /product/families
  def index 
    @q = Family.ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @families = @q.result.page(params[:page])
  end

  # GET /product/families/new
  def new
    @family = Family.new
  end

  def edit; end

  # POST /product/families
  def create
    @family = Family.new(family_params)
    if @family.save 
      redirect_to products_families_path
    else
      render :new, alert: :error
    end
  end

  # PUT/PATCH /products/families/1
  def update
    if @family.update(family_params)
      redirect_to products_family_path
    else
      render :edit, alert: :error 
    end
  end

  # DELETE /products/families/1
  def destroy 
    destroy_model(@family)
  end

  private

  def set_family
    @family = Family.find(params[:id])
  end

  def family_params
    params.require(:family).permit(:name, :producer_id)
  end
end
