class InventoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_inventory, only: [:edit, :update, :destroy, :show]
  before_action :set_move_detail, only: [:show]
  authorize_resource

  # GET /inventories
  def index
    @q = Inventory.ransack(params[:q])
    @q.sorts = 'product.name asc' if @q.sorts.empty?
    @inventories = @q.result
                    .select('inventories.product_id')
                    .group('inventories.product_id')
                    .page(params[:page])

    @p = Deposit.ransack(params[:p])
    @deposits = @p.result
  end
 
  # GET /inventories/new
  def new
    @inventory = Inventory.new
  end
 
  def deposit_stock
    @inventories = Inventory.where(product_id: params[:product_id], product_exist: true)
    @inventory = @inventories.take   
    @inventories = @inventories.group_by {|i| i.deposit}
  end

  # Devuelve todos los productos asociados a un (1) depósito
  def per_deposit
    if params[:deposit_id].present? 
      cookies[:deposit_id] = params[:deposit_id]
    end
    @q = Inventory.ransack(params[:q],deposit_id: cookies[:deposit_id] , product_exist: true)
    @inventories = @q.result
    @inventories = @inventories.group_by {|i| i.product}
    @deposit = Deposit.find(cookies[:deposit_id]  ) 
  end
  
  def show; end

  def edit; end 

  # POST /inventories
  def create
    inventory_params[:product_quantity].to_i.times do |i|
      @inventory = Inventory.new(inventory_params)
      @inventory.save
    end 
    redirect_to inventories_path
  end

  # PUT/PATCH /inventories/1
  def update
    if @inventory.update(inventory_params)
      redirect_to per_deposit_inventories_path(deposit_id: params[:deposit_id])
    else
      render :edit, alert: :error
    end
  end
  
  # DELETE /inventories/1
  def destroy
    destroy_model(@inventory)
  end

  def download_product
    puts params
    setup_search
    # @inventories = @q.result
    exp = InventoryExporter.new(@inventories)
    send_data exp.to_excel_workbook.read,
              filename: "#{exp.filename}.xlsx",
              type: InventoryExporter::EXCEL_MIME_TYPE
  end

  def download_deposit_product
    puts params
    setup_search_deposit
    # @inventories = @q.result
    exp = InventoryDepositExporter.new(@inventories, @deposit)
    send_data exp.to_excel_workbook.read,
              filename: "#{exp.filename}.xlsx",
              type: InventoryDepositExporter::EXCEL_MIME_TYPE
  end

  
  private

  def setup_search_deposit
    @q = Inventory.ransack(params[:q],deposit_id: cookies[:deposit_id] , product_exist: true)
    @inventories = @q.result
    @inventories = @inventories.group_by {|i| i.product}
    @deposit = Deposit.find(cookies[:deposit_id]  ) 
  end

  def setup_search
    @q = Inventory.ransack(params[:q])
    @q.sorts = 'product.name asc' if @q.sorts.empty?
    @inventories = @q.result
                    .select('inventories.product_id, inventories.deposit_id')
                    .group('inventories.product_id, inventories.deposit_id')
                    .order(' product_id asc')
                    
  end
  
  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  def set_move_detail
    @move_details = MoveDetail.where(inventory_id: params[:id])
  end

  def inventory_params
    params.require(:inventory).permit(:product_id, :deposit_id, :provider_id, :firmware_version, :serial_number, :mac_address, :product_exist, :product_quantity)
  end
end