class Products::ProducersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_producer, only: [:edit, :update, :destroy]
  authorize_resource

  # GET /product/producers
  def index 
    @q = Producer.ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @producers = @q.result.page(params[:page])
  end

  # GET /product/producers/new
  def new
    @producer = Producer.new
  end

  def edit; end

  # POST /product/producers
  def create
    @producer = Producer.new(producer_params)
    if @producer.save 
      redirect_to products_producers_path
    else
      render :new, alert: :error
    end
  end

  # PUT/PATCH /products/producers/1
  def update
    if @producer.update(producer_params)
      redirect_to products_producers_path
    else
      render :edit, alert: :error 
    end
  end

  # DELETE /products/producers/1
  def destroy 
    destroy_model(@producer)
  end

  def download
    setup_search
    @producers = @q.result
    exp = ProducerExporter.new(@producers)
    send_data exp.to_excel_workbook.read,
              filename: "#{exp.filename}.xlsx",
              type: ProducerExporter::EXCEL_MIME_TYPE
  end

  private
  def setup_search
    @q = Producer.ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @producers = @q.result.page(params[:page]).per(10)
  end

  def set_producer
    @producer = Producer.find(params[:id])
  end

  def producer_params
    params.require(:producer).permit(:name)
  end
end
