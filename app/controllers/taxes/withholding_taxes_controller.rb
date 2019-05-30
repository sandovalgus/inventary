class Taxes::WithholdingTaxesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_withholding_tax, only: [:show, :edit, :update, :destroy]
    authorize_resource
  
    # GET /tax/tax_categories WithholdingTax
    def index 
      @q = WithholdingTax.ransack(params[:q])
      @q.sorts = 'name asc' if @q.sorts.empty?
      @withholding_taxes = @q.result.page(params[:page])
    end
  
    # GET /tax/tax_categories/new
    def new
      @withholding_tax = WithholdingTax.new
    end
  
    def edit; end
  
    # POST /tax/tax_categories
    def create
      @withholding_tax = WithholdingTax.new(withholding_taxes_params)
      if @withholding_tax.save 
        redirect_to taxes_withholding_taxes_path
      else
        render :new, alert: :error
      end
    end
  
    # PUT/PATCH /tax/tac_categories/1
    def update
      if @withholding_tax.update(withholding_taxes_params)
        redirect_to taxes_withholding_taxes_path
      else
        render :edit, alert: :error 
      end
    end
  
    # DELETE /tax/tax_categories/1
    def destroy 
      destroy_model(@withholding_tax)
    end
  
    private
  
    def set_withholding_tax
      @withholding_tax = WithholdingTax.find(params[:id])
    end
  
    def withholding_taxes_params
      params.require(:withholding_tax).permit(:withholding, :comment)
    end
  end
  