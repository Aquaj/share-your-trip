class RoadmapsController < ApplicationController
  before_action :find_roadmap, only: [:edit, :update, :destroy, :show]
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @roadmaps = policy_scope(Roadmap).where("user_id = ?", current_user.id)
  end

  def show
    authorize(@roadmap)
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
    experiences = current_user.wishlisted_experiences
    experiences.uniq.sort! { |exp| -exp.average_rating }
    @groups = experiences.group_by { |e| e.country }
    @groups = @groups.each { |country, g| @groups[country] = g.group_by { |e| e.city } }
  end

  def destroy
    authorize @roadmap
    @roadmap.destroy
  end

  def send_roadmap
    @roadmap = Roadmap.find(params[:roadmap_id])
    authorize @roadmap
    UserMailer.itinerary(current_user, @roadmap).deliver_now
    flash[:mail] = "Votre itinéraire vous a été envoyé par email"
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
