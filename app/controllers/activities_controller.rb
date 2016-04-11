class ActivitiesController < ApplicationController
    before_action :find_activity, only: [:update, :destroy]
    before_action :find_experience, only: [:create]
    before_action :find_roadmap, only: [:create]

    def create
      planned = nil
      planned = @roadmap.start_date if params[:single_day] == 'true'
      @activity = Activity.new(experience: @experience, roadmap: @roadmap, planned_on: planned)
      authorize @activity
      if @activity.save
        @details = @roadmap.details
        @date_needed = !params[:single_day]
        respond_to do |format|
          format.js
        end
      else
        respond_to do |format|
          format.js
        end
      end
    end

    def update
      authorize @activity
      if @activity.update(activity_params)
        respond_to do |format|
          format.js
        end
      else
        respond_to do |format|
          format.js
        end
      end
    end

    def destroy
      authorize @activity
      @id = @activity.id
      roadmap = @activity.roadmap
      @activity.destroy
      @details = roadmap.details
      respond_to do |format|
        format.js
      end
    end

  private

    def find_activity
      @activity = Activity.find(params[:id])
    end

    def find_experience
      @experience = Experience.find(params[:experience_id])
    end

    def find_roadmap
      @roadmap = Roadmap.find(params[:roadmap_id])
    end

    def activity_params
      params.permit(:roadmap_id, :experience_id, :planned_on)
    end
end
