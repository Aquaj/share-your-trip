class RoadmapsController < ApplicationController
  before_action :find_roadmap, only: [:edit, :update, :destroy, :show]

  def index
    @roadmaps = policy_scope(Roadmap)
  end

  def show
    authorize @roadmap
  end

  def new
    @roadmap = Roadmap.new
    authorize @roadmap
    if @roadmap.start_destination.present?
      around = Geocoder.address(@roadmap.start_destination).split(", ")[-1]
    end
    @experiences = Experience.search({address: around}, policy_scope(Experience)) # For now > All.
    @experiences += current_user.wishlisted_experiences
  end

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
      around = Geocoder.address(@roadmap.start_destination).split(", ")[-1]
    end
    @experiences = Experience.search({address: around}, policy_scope(Experience)) # For now > All.
    @experiences += current_user.wishlisted_experiences
  end

  def destroy
    authorize @roadmap
    @roadmap.destroy
  end

private

  def find_roadmap
    @roadmap = Roadmap.find(params[:id])
  end

  def roadmap_params
    params.require(:roadmap).permit(:user_id, :start_date, :end_date, :start_destination, :end_destination, :travellers_num)
  end
end
