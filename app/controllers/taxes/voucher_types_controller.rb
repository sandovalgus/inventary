class Taxes::VoucherTypesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_voucher_type, only: [:show, :edit, :update, :destroy]
    authorize_resource
  
    # GET /tax/voucher_types
    def index 
      @q = VoucherType.ransack(params[:q])
      @q.sorts = 'name asc' if @q.sorts.empty?
      @voucher_types = @q.result.page(params[:page])
    end
  
    # GET /tax/voucher_type/new
    def new
      @voucher_type = VoucherType.new
    end
  
    def edit; end
  
    # POST /tax/voucher_types
    def create
      @voucher_type = VoucherType.new(voucher_type_params)
      if @voucher_type.save 
        redirect_to taxes_voucher_types_path
      else
        render :new, alert: :error
      end
    end
  
    # PUT/PATCH /tax/voucher_type/1
    def update
      if @voucher_type.update(voucher_type_params)
        redirect_to taxes_voucher_types_path
      else
        render :edit, alert: :error 
      end
    end
  
    # DELETE /tax/voucher_type/1
    def destroy 
      destroy_model(@voucher_type)
    end
  
    private
  
    def set_voucher_type
      @voucher_type = VoucherType.find(params[:id])
    end
  
    def voucher_type_params
      params.require(:voucher_type).permit(:name, :description)
    end
  end
  