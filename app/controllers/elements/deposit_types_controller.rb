class Elements::DepositTypesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_deposit_type, only: [:edit, :update, :destroy]
    authorize_resource
  
    # GET /elements/work_types
    def index
      @q = DepositType.ransack(params[:q])
      @q.sorts = 'name asc' if @q.sorts.empty?
      @deposit_types = @q.result.page(params[:page])
    end
  
    # GET /elements/work_types/new
    def new
      puts "----intro new ----------"
      @deposit_type = DepositType.new
    end
  
    def edit; end
  
    # POST /elements/work_types
    def create
      puts "----intro create ----------"
      @deposit_type = DepositType.new(deposit_type_params)
      if @deposit_type.save
        redirect_to elements_deposit_types_path
      else
        render :new, alert: :error
      end
    end
  
    # PUT/PATCH /elements/work_types/1
    def update
      if @deposit_type.update(deposit_type_params)
        redirect_to elements_deposit_types_path
      else
        render :edit, alert: :error
      end
    end
  
    # DELETE /elements/work_types/1
    def destroy
      destroy_model(@deposit_type)
    end
  
    private
  
    def set_deposit_type
      puts "---- set_deposit_type ----------"
      @deposit_type = DepositType.find(params[:id])
    end
  
    def deposit_type_params
      params.require(:deposit_type).permit( :name, :description)
    end
  end
  