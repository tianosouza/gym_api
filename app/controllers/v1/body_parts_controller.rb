module V1
  class BodyPartsController < ApplicationController
  before_action :set_body_part, only: [ :show, :update, :destroy ]

  # GET /body_parts
  def index
    @body_parts = BodyPart.all
    render json: @body_parts
  end

  # GET /body_parts/:id
  def show
    render json: @body_part
  end

  # POST /body_parts
  def create
    @body_part = BodyPart.new(body_part_params)
    if @body_part.save
      render json: @body_part, status: :created
    else
      render json: @body_part.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /body_parts/:id
  def update
    if @body_part.update(body_part_params)
      render json: @body_part
    else
      render json: @body_part.errors, status: :unprocessable_entity
    end
  end

  # DELETE /body_parts/:id
  def destroy
    @body_part.destroy
  end

  private

  def set_body_part
    @body_part = BodyPart.find(params[:id])
  end

  def body_part_params
    params.require(:body_part).permit(:name)
  end
  end
end
