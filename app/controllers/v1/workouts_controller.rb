module V1
  class WorkoutsController < ApplicationController
    before_action :set_workout, only: %i[ show update destroy ]

    def index
      @workouts = Workout.all
      render json: @workouts, include: [ :user ]
    end

    def show
      render json: @workout, include: [ :user ]
    end

    def create
      @workout = Workout.new(workout_params)
      # debugger
      if @workout.save
        render json: @workout, include: [ :user ], status: :created
      else
        render json: @workout.errors, status: :unprocessable_entity
      end
    end

    def update
      if @workout.update(workout_params)
        render json: @workout, include: [ :user ], status: :ok, location: @workout
      else
        render json: @workout.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @workout.destroy!
    end

    private

    def set_workout
      @workout = Workout.find(params[:id])
    end

    def workout_params
      params.require(:workout).permit(:user_id, :title, :description)
    end
  end
end
