class Elements::DepositsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_deposit, only: [:edit, :update, :destroy]
  authorize_resource

  # GET /elements/deposits/select
  def select
    @deposit_moves = Move.joins(move_details: :site_to).where(status: 'en_carga').distinct
  end

  # POST /elements/deposits/move-detail => Add move details
  def move_detail
    params[:q].split(',').map(&:to_i).each do |productId|
      p "producto: #{productId}"
      inventory = Inventory.find(productId)
      @move_detail = MoveDetail.new(site_to_id: params[:site_to_id], site_from_id: inventory.deposit_id, inventory_id: productId, move_id: params[:move_id])
      @move_detail.save!
      inventory.update_attributes(deposit_id: params[:site_to_id], status: :en_movimiento)
    end
    redirect_back fallback_location: inventories_path
  end

  #  GET /elements/deposits/move
  def move
    id = params[:q].split(",").map { |s| s.to_i }
    @inventories = Inventory.find(id)
    @@product_moves = @inventories
    @inventory = @inventories.first
    @move = Move.new  
    @move.move_details.build
  end   

  # Crear un movimiento entre depósitos
  # Se crea el movimiento en la clase Move y también su respectivo detalle en MoveDetail
  # El estado inicial de Move es 'en_carga'
  # Cada producto del detalle cambia su estado a 'en_movimiento' hasta ser finalizado o eliminado
  def create_move
    @move = Move.new(move_params)
    if @move.save!
      site_to_id = params.dig(:move, :move_details_attributes, "0", :site_to_id).to_i
      @@product_moves.each do |inv|
        @move_detail = MoveDetail.new(site_to_id: site_to_id, site_from_id: inv.deposit.id, inventory_id: inv.id, move_id: @move.id)
        inv.product_quantity = 0
        inv.status = 1
        inv.save!
        @move_detail.save!
      end
      redirect_back fallback_location: inventories_path
    end
  end

  def create_detail_move
    @move = Move.find(id: params[:move_id])
  end

  # GET /elements/deposits/search
  def search
    setup_search  

    @deposits = @deposits.all unless search_params? && valid_params?
    @name_cont = params.dig(:q, :name_cont)
  end

  # GET /elements/deposits
  def index
    # setup_search
    @q = Deposit.ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @deposits = @q.result.page(params[:page])
  end

  # GET /elements/deposits/new
  def new
    @deposit = Deposit.new
  end

  def edit; end

  # POST /elements/deposits
  def create
    @deposit = Deposit.new(deposit_params)
    if @deposit.save
      redirect_to elements_deposits_path
    else
      render :new, alert: :error
    end
  end

  # PUT/PATCH /elements/deposits/1
  def update
    if @deposit.update(deposit_params)
      redirect_back fallback_location: elements_deposits_path
    else
      render :edit, alert: :error
    end
  end

  # DELETE /elements/deposits/1
  def destroy
    destroy_model(@deposit)
  end
 
  def download
    setup_search
    @deposits = @q.result
    exp = DepositExporter.new(@deposits)
    send_data exp.to_excel_workbook.read,
              filename: "#{exp.filename}.xlsx",
              type: DepositExporter::EXCEL_MIME_TYPE
  end
  
  private

  def setup_search
    @q = Deposit.ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @deposits = @q.result.page(params[:page]).per(10)
    puts ' setup_search ------------'
    puts @deposits
  end

  # Buscar solamente si el usuario ingresó 3 o más caracteres para limitar la
  # cantidad de resultados.
  def valid_params?
    id = params.dig(:q, :name_cont)
    id && id.size > 2
  end

  def set_deposit
    @deposit = Deposit.find(params[:id])
  end

  def move_params
    params.require(:move).permit(:move_date, :user_register_id, :user_take_id, :voucher_type_id, :voucher_number, move_details_attributes: [:site_to_id, :site_from_id])
  end

  def deposit_params
    params.require(:deposit).permit(:name, :description, :address, :city_id, :province_id, :country_id, :deposit_type_id)
  end
end
