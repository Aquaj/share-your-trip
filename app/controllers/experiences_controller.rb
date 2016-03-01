class ExperiencesController < ApplicationController
  before_action :find_experience, only: [:edit, :update, :destroy, :show]
  skip_before_action :authenticate_user!, only: [:index, :new, :show]

  def index
    @experiences = policy_scope(Experience).search(params[:search])
    @markers = Gmaps4rails.build_markers(@experiences) do |experience, marker|
      marker.lat experience.latitude
      marker.lng experience.longitude
    end
  end

  def show
    authorize @experience
    @rating = current_user.ratings.new
    @rating.experience_id = @experience.id
  end

  def new
    @experience = current_user.experiences.new
    authorize @experience
  end

  def create
    @experience = current_user.experiences.new(experience_params)
    authorize @experience
    if @experience.save
      redirect_to @experience
    else
      render 'new'
    end
  end

  def update
    @experience.update(experience_params)
    authorize @experience
    if @experience.save
      redirect_to @experience
    else
      render 'edit'
    end
  end

  def edit
    authorize @experience
  end

  def destroy
    authorize @experience
    @experience.destroy
  end

  def my_experiences
    @experiences = policy_scope(Experience).where("user_id = ?", current_user)
  end

private

  def find_experience
    @experience = Experience.find(params[:id])
  end

  def experience_params
    params.require(:experience).permit(:user_id, :category, :description, :address, :title, photos: [])
  end

end
