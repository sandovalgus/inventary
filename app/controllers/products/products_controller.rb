class Products::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:edit, :update, :destroy]
  authorize_resource

  # GET /product/products/search
  def search
    setup_search

    @products = @products.all unless search_params? && valid_params?
    @identification_cont = params.dig(:q, :identification_cont)
  end

  # GET /product/products
  def index 
    setup_search
    @q = Product.ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @products = @q.result.page(params[:page])
  end

  # GET /product/products/new
  def new
    @product = Product.new
  end

  def edit; end

  # POST /product/products
  def create
    @product = Product.new(product_params)
    if @product.save 
      redirect_to products_products_path
    else
      render :new, alert: :error
    end
  end

  # PUT/PATCH /products/products/1
  def update
    if @product.update(product_params)
      redirect_to products_products_path
    else
      render :edit, alert: :error 
    end
  end 

  # DELETE /products/products/1
  def destroy 
    destroy_model(@product)
  end

  def download
    setup_search
    @products = @q.result
    exp = ProductExporter.new(@products)
    send_data exp.to_excel_workbook.read,
              filename: "#{exp.filename}.xlsx",
              type: ProductExporter::EXCEL_MIME_TYPE
  end

  def product_number_validator
    if params[:product_number].size <= 1
      render json: { valid: false }
    elsif Product.find_by_product_number(params[:product_number])
      render json: { valid: false }
    else
      render json: { valid: true }
    end
  end
 
  private

  def setup_search
    @q = Product.ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @products = @q.result.page(params[:page]).per(10)
  end

  # Buscar solamente si el usuario ingresó 3 o más caracteres para limitar la
  # cantidad de resultados.
  def valid_params?
    id = params.dig(:q, :identification_cont)
    id && id.size > 2
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_number, :name, :description, :ac, :power_in, :power_out, :poe, :dbi, :category_id, :producer_id, :product_type_id, :family_id, :stock_min_default, :reorder_point_default, :unit)
  end
end 
 