module V1
  class EquipmentsController < ApplicationController
    before_action :set_equipment, only: [ :show, :update, :destroy ]

    # GET /equipments
    def index
      @equipments = Equipment.all
      render json: @equipments
    end

    # GET /equipments/:id
    def show
      render json: @equipment
    end

    # POST /equipments
    def create
      @equipment = Equipment.new(equipment_params)
      if @equipment.save
        render json: @equipment, status: :created
      else
        render json: @equipment.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /equipments/:id
    def update
      if @equipment.update(equipment_params)
        render json: @equipment
      else
        render json: @equipment.errors, status: :unprocessable_entity
      end
    end

    # DELETE /equipments/:id
    def destroy
      @equipment.destroy
    end

    private

    def set_equipment
      @equipment = Equipment.find(params[:id])
    end

    def equipment_params
      params.require(:equipment).permit(:name)
    end
  end
end
