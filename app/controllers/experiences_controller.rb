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
    @close_by = @experience.nearbys(10)
    # Display close by experiences.
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
    if @experience.destroy
      redirect_to experiences_path
    else
      flash[:alert] = "Une erreur s'est produite."
      render @experience
    end
  end

  def my_experiences
    @experiences = policy_scope(Experience).where("user_id = ?", current_user)
    authorize @experiences
  end

  def send_experience
    @experience = Experience.find(params[:experience_id])
    authorize @experience
    UserMailer.experience(params[:send_experience][:recipient], experience_url(@experience)).deliver_now
    flash[:mail] = "Coup de coeur partagé à #{params[:send_experience][:recipient]}."
    redirect_to @experience
  end

private

  def find_experience
    @experience = Experience.find(params[:id])
  end

  def experience_params
    params.require(:experience).permit(:user_id, :category_id, :price, :url, :description, :address, :title, photos: [])
  end

end
