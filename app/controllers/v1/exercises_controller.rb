module V1
  class ExercisesController < ApplicationController
    skip_before_action :ensure_json_request, only: %i[index show edit create]
    before_action :set_exercise, only: %i[show update destroy edit]

    def index
      Rails.logger.info "Fetching all exercises"
      #debugger
      @exercises = Exercise.all.limit(10)
      respond_to do |format|
        format.html # renderiza index.html.erb
        format.json { render json: @exercises }
      end
    end

    def show
      Rails.logger.info "Showing exercise with ID: #{params[:id]}"
      respond_to do |format|
        format.html # renderiza show.html.erb
        format.json { render json: @exercise }
      end
    end

    def new
      @exercise = Exercise.new
    end

    def create
      @exercise = Exercise.new(exercise_params)

      if params[:exercise][:video_file].present?
        @exercise.video_file.attach(params[:exercise][:video_file])
      end

      if params[:exercise][:image_file].present?
        @exercise.image_file.attach(params[:exercise][:image_file])
      end

      if @exercise.save
        respond_to do |format|
          format.html { redirect_to @exercise }
          format.json { render json: @exercise, status: :created, location: @exercise }
        end
      else
        respond_to do |format|
          format.html { render :new }
          format.json { render json: @exercise.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
      @exercise = Exercise.find(params[:id])
    end

    def update
      if @exercise.update(exercise_params)
        if params[:exercise][:video_file].present?
          @exercise.video.attach(params[:exercise][:video_file])
        end

        if params[:exercise][:image_file].present?
          @exercise.image.attach(params[:exercise][:image_file])
        end

        respond_to do |format|
          format.html { redirect_to @exercise, notice: "Exercise was successfully updated." }
          format.json { render json: @exercise }
        end
      else
        respond_to do |format|
          format.html { render :edit }
          format.json { render json: @exercise.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @exercise.destroy
      respond_to do |format|
        format.html { redirect_to exercises_url, notice: "Exercise was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

    def set_exercise
      Rails.logger.info "Fetching exercise with ID: #{params[:id]}"
      @exercise = Exercise.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.error "Exercise not found: #{e.message}"
      respond_to do |format|
        format.html { redirect_to exercises_url, alert: "Exercise not found." }
        format.json { render json: { error: "Exercise not found" }, status: :not_found }
      end
    end

    def exercise_params
      params.require(:exercise).permit(
        :name, :instructions, :exercise_type, :is_favorite, :video_name, :image_name, :num_exercises, :user_id, :image_file, :video_file,
        equipament_ids: [], body_part_ids: [], target_muscle_ids: [], synergist_muscle_ids: []
      )
    end
  end
end
