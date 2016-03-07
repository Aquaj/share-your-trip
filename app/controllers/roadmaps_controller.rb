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
  end

  def create
    @roadmap = Roadmap.new(roadmap_params)
    authorize @roadmap
    if @roadmap.save
      redirect_to @roadmap
    else
      render 'new'
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
