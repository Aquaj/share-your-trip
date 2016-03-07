class ActivitiesController < ApplicationController
    before_action :find_activity, only: [:update, :destroy]
    before_action :find_experience, only: [:create]
    before_action :find_roadmap, only: [:create]

    def create
      @activity = Activity.new(experience: @experience, roadmap: @roadmap)
      authorize @activity
      if @activity.save
        respond_to do |format|
          format.js  # <-- will render `app/views/reviews/create.js.erb`
        end
      else
        respond_to do |format|
          format.js  # <-- will render `app/views/reviews/create.js.erb`
        end
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
      @id = @activity.id
      @activity.destroy
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
