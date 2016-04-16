class ActivitiesController < ApplicationController
    before_action :find_activity, only: [:update, :destroy]
    before_action :set_activity, only: [:up, :down]
    before_action :find_experience, only: [:create]
    before_action :find_roadmap, only: [:create]

    def create
      planned = nil
      planned = @roadmap.start_date if params[:single_day] == 'true'
      @activity = @roadmap.activities.new(experience: @experience, planned_on: planned)
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

    def up
      authorize @activity
      @activity.up
      @sisters = @activity.sisters
    end

    def down
      authorize @activity
      @activity.down
      @sisters = @activity.sisters
    end

  private

    def find_activity
      @activity = Activity.find(params[:id])
    end

    def set_activity
      @activity = Activity.find(params[:activity_id])
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
