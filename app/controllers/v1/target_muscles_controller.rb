module V1
  class TargetMusclesController < ApplicationController
    before_action :set_target_muscle, only: [ :show, :update, :destroy ]

    # GET /target_muscles
    def index
      @target_muscles = TargetMuscle.all
      render json: @target_muscles
    end

    # GET /target_muscles/:id
    def show
      render json: @target_muscle
    end

    # POST /target_muscles
    def create
      @target_muscle = TargetMuscle.new(target_muscle_params)
      if @target_muscle.save
        render json: @target_muscle, status: :created
      else
        render json: @target_muscle.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /target_muscles/:id
    def update
      if @target_muscle.update(target_muscle_params)
        render json: @target_muscle
      else
        render json: @target_muscle.errors, status: :unprocessable_entity
      end
    end

    # DELETE /target_muscles/:id
    def destroy
      @target_muscle.destroy
    end

    private

    def set_target_muscle
      @target_muscle = TargetMuscle.find(params[:id])
    end

    def target_muscle_params
      params.require(:target_muscle).permit(:name)
    end
  end
end
