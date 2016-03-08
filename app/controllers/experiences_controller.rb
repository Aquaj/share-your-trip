class ExperiencesController < ApplicationController
  before_action :find_experience, only: [:edit, :update, :destroy, :show]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @experiences = Experience.search(params[:search], policy_scope(Experience))
    @markers = Gmaps4rails.build_markers(@experiences) do |experience, marker|
      marker.lat experience.latitude
      marker.lng experience.longitude
    end
  end

  def show
    authorize @experience
    @close_by = @experience.nearbys.select do |experience|
      # Only display Experiences with higher or equal average rating.
      experience.average_rating >= @experience.average_rating
    end
    if user_signed_in?
      @rating = current_user.ratings.new
      @rating.experience_id = @experience.id
      @wished = current_user.wishlisted_experiences.include? @experience
      @wishlist = @experience.wishlists.find_by(user: current_user)
    end
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
    authorize @experiences
  end

  def extract_address
    byebug
    gps_coord = []
    gps_coord << EXIFR::JPEG.new(params[:image_url]).gps.longitude
    gps_coord << EXIFR::JPEG.new(params[:image_url]).gps.latitude
    @address = Geocoder.search(gps_coord)
      respond_to do |format|
        format.js
      end
  end

private

  def find_experience
    @experience = Experience.find(params[:id])
  end

  def experience_params
    params.require(:experience).permit(:user_id, :category, :description, :address, :country, :title, photos: [])
  end

end
