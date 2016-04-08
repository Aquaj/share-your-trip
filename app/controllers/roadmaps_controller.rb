class RoadmapsController < ApplicationController
  before_action :find_roadmap, only: [:edit, :update, :destroy, :show]
  skip_after_action :verify_authorized, only: [:send_roadmap]

  def index
    @roadmaps = policy_scope(Roadmap)
  end

  def show
    authorize @roadmap
    # Ensuring basic completion before display.
    if @roadmap.start_destination.nil? ||
       @roadmap.end_destination.nil? ||
       @roadmap.start_destination.empty? ||
       @roadmap.end_destination.empty?

      redirect_to edit_roadmap_path(@roadmap)
    end
  end

  # New doesn't exist. You want a new one => Create > Edit

  def create
    @roadmap = current_user.roadmaps.new
    authorize @roadmap
    if @roadmap.save
      redirect_to edit_roadmap_path(@roadmap)
    else
      flash[:alert] = "Sorry, we encountered a problem."
      redirect roadmaps_path
    end
  end

  def update
    @roadmap.update(roadmap_params)
    authorize @roadmap
    if @roadmap.save
      redirect_to @roadmap
    else
      render 'edit'
    end
  end

  def edit
    authorize @roadmap
    if @roadmap.start_destination.present?
      around = @roadmap.start_city
    end
    @experiences = []
    @experiences += current_user.wishlisted_experiences
    @experiences += Experience.search({address: around}, policy_scope(Experience)) # For now > All.
    @experiences.uniq.sort!{ |exp| -exp.average_rating }
  end

  def destroy
    authorize @roadmap
    @roadmap.destroy
  end

  def send_roadmap
    @roadmap = Roadmap.find(params[:roadmap_id])
    UserMailer.itinerary(current_user, @roadmap).deliver
    flash[:notice] = "Votre itinéraire vous a été envoyé par email"
    redirect_to @roadmap
  end

private

  def find_roadmap
    @roadmap = Roadmap.find(params[:id])
  end

  def roadmap_params
    params.require(:roadmap).permit(:user_id, :start_date, :end_date, :start_destination, :end_destination, :travellers_num)
  end
end
