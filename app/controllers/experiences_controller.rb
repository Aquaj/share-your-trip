class ExperiencesController < ApplicationController
    before_action :find_experience, only: [:edit, :update, :destroy, :show]

    def index
      @experiences = Experience.search(params[:search])
    end

    def show
    end

    def new
      @experience = Experience.new
    end

    def create
      @experience = Experience.new(experience_params)
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
