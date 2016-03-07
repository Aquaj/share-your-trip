class ActivitiesController < ApplicationController
    before_action :find_activity, only: [:update, :destroy]
    before_action :find_experience, only: [:create]

    def create
      @activity = @experience.activities.new(activity_params)
      authorize @activity
      if @activity.save
        redirect_to @activity
      else
        render "roadmap/new"
      end
    end

    def update
      @activity.update(activity_params)
      authorize @activity
      if @activity.save
        redirect_to @activity
      else
        render "roadmap/new"
      end
    end

    def destroy
      authorize @activity
      @activity.destroy
    end

  private

    def find_activity
      @activity = Activity.find(params[:id])
    end

    def find_experience
      @experience = Experience.find(params[:activity_id])
    end

    def activity_params
      params.require(:activity).permit(:roadmap_id, :experience_id, :planned_on)
    end
end
