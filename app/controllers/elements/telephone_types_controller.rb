class Elements::TelephoneTypesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_telephone_type, only: [:edit, :update, :destroy]
    authorize_resource
  
    # GET /elements/telephone_types
    def index
      @q = TelephoneType.ransack(params[:q])
      @q.sorts = 'name asc' if @q.sorts.empty?
      @telephone_types = @q.result.page(params[:page]) 
    end

  
    # GET /elements/telephone_types/new
    def new
      @telephone_type = TelephoneType.new
    end
  
    def edit; end
  
    # POST /elements/telephone_types
    def create
      @telephone_type = TelephoneType.new(telephone_type_params)
      if @telephone_type.save
        redirect_to elements_telephone_types_path
      else
        render :new, alert: :error
      end
    end
  
    # PUT/PATCH /elements/telephone_types/1
    def update
      if @telephone_type.update(telephone_type_params)
        redirect_to elements_telephone_types_path
      else
        render :edit, alert: :error
      end
    end
  
    # DELETE /elements/telephone_types/1
    def destroy
      destroy_model(@telephone_type)
    end
  
    private
  
    def set_telephone_type
      @telephone_type = TelephoneType.find(params[:id])
    end
  
    def telephone_type_params
      params.require(:telephone_type).permit(:name, :description)
    end
  end
  