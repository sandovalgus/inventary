class Products::ProductTypesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_product_type, only: [:edit, :update, :destroy]
    authorize_resource
  
    # GET /product/families
    def index 
      @q = ProductType.ransack(params[:q])
      @q.sorts = 'name asc' if @q.sorts.empty?
      @product_types = @q.result.page(params[:page])
    end
  
    # GET /product/product_types/new
    def new
      @product_type = ProductType.new
    end
  
    def edit; end
  
    # POST /product/product_types
    def create
      @product_type = ProductType.new(product_type_params)
      if @product_type.save 
        redirect_to products_product_types_path
      else
        render :new, alert: :error
      end
    end
  
    # PUT/PATCH /products/product_types/1
    def update
      if @product_type.update(product_type_params)
        redirect_to products_product_types_path 
      else
        render :edit, alert: :error 
      end
    end
  
    # DELETE /products/product_types/1
    def destroy 
      destroy_model(@product_type)
    end
  
    private
  
    def set_product_type
      @product_type = ProductType.find(params[:id])
    end
  
    def product_type_params
      params.require(:product_type).permit(:name, :description)
    end
  end
  