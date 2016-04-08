class ExperiencesController < ApplicationController
  before_action :find_experience, only: [:edit, :update, :destroy, :show]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @experiences = Experience.search(params[:search], policy_scope(Experience))
    @markers = Gmaps4rails.build_markers(@experiences) do |experience, marker|
      marker.lat experience.latitude
      marker.lng experience.longitude
    end
    sort, order = nil, nil
    if params[:search]
      sort = params[:search][:sort]
      order = params[:search][:order]
    end
    if sort == "note"
      @experiences = @experiences.sort { |e, f| e.average_rating - f.average_rating }
    elsif sort == "date"
      @experiences = @experiences.sort { |e, f| e.created_at - f.created_at }
    end
    @experiences = @experiences.reverse if order == "desc"
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

private

  def find_experience
    @experience = Experience.find(params[:id])
  end

  def experience_params
    params.require(:experience).permit(:user_id, :category, :description, :address, :title, photos: [])
  end

end
