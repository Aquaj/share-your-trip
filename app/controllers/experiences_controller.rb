class ExperiencesController < ApplicationController
    before_action :find_experience, only: [:edit, :update, :destroy, :show]

    def index
      @experiences = Experience.search(params[:search])
    end

    def show
    end

    def new
      @experience = current_user.experience.new
    end

    def create
      @experience = current_user.experience.new(experience_params)
      if @experience.save
        redirect_to @experience
      else
        render 'new'
      end
    end

    def update
    end

    def edit
    end

    def destroy
      @experience.destroy
    end

  private

    def find_experience
      @experience = Experience.find(params[:id])
    end

    def experience_params
      params.require(:experience).permit(:user_id, :category, :description, :address, :title)
    end
end
