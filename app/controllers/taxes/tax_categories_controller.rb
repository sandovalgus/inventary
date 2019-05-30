class Taxes::TaxCategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_tax_category, only: [:show, :edit, :update, :destroy]
    authorize_resource
  
    # GET /tax/tax_categories
    def index 
      @q = TaxCategory.ransack(params[:q])
      @q.sorts = 'name asc' if @q.sorts.empty?
      @tax_categories = @q.result.page(params[:page])
    end
  
    # GET /tax/tax_categories/new
    def new
      @tax_category = TaxCategory.new
    end
  
    def edit; end
  
    # POST /tax/tax_categories
    def create
      @tax_category = TaxCategory.new(tax_category_params)
      if @tax_category.save 
        redirect_to taxes_tax_categories_path
      else
        render :new, alert: :error
      end
    end
  
    # PUT/PATCH /tax/tac_categories/1
    def update
      if @tax_category.update(tax_category_params)
        redirect_to taxes_tax_categories_path
      else
        render :edit, alert: :error 
      end
    end
  
    # DELETE /tax/tax_categories/1
    def destroy 
      destroy_model(@tax_category)
    end
  
    private
  
    def set_tax_category
      @tax_category = TaxCategory.find(params[:id])
    end
  
    def tax_category_params
      params.require(:tax_category).permit(:name, :comment)
    end
  end
  