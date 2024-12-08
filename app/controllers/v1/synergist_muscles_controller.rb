module V1
  class SynergistMusclesController < ApplicationController
    before_action :set_synergist_muscle, only: [:show, :update, :destroy]

    # GET /synergist_muscles
    def index
      @synergist_muscles = SynergistMuscle.all
      render json: @synergist_muscles
    end

    # GET /synergist_muscles/:id
    def show
      render json: @synergist_muscle
    end

    # POST /synergist_muscles
    def create
      @synergist_muscle = SynergistMuscle.new(synergist_muscle_params)
      if @synergist_muscle.save
        render json: @synergist_muscle, status: :created
      else
        render json: @synergist_muscle.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /synergist_muscles/:id
    def update
      if @synergist_muscle.update(synergist_muscle_params)
        render json: @synergist_muscle
      else
        render json: @synergist_muscle.errors, status: :unprocessable_entity
      end
    end

    # DELETE /synergist_muscles/:id
    def destroy
      @synergist_muscle.destroy
    end

    private

    def set_synergist_muscle
      @synergist_muscle = SynergistMuscle.find(params[:id])
    end

    def synergist_muscle_params
      params.require(:synergist_muscle).permit(:name)
    end
  end
end
