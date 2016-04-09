class RatingsController < ApplicationController
  def create
    @rating = current_user.ratings.new(rating_params)
    authorize(@rating)
    if @rating.save
      flash.delete(:alert);
      redirect_to @rating.experience
    else
      @experience = @rating.experience
      @close_by = @experience.nearbys(10)
      @oldrating = @rating
      @rating = current_user.ratings.new
      @rating.experience_id = @experience.id
      @wished = current_user.wishlisted_experiences.include? @experience
      @wishlist = @experience.wishlists.find_by(user: current_user)
      flash[:alert] = "Veuillez laisser une note."
      render "experiences/show"
    end
  end

  def destroy
    @rating = Rating.find(params[:id])
    @experience = @rating.experience
    authorize(@rating)
    if @rating.destroy
      flash.delete(:alert);
      redirect_to @experience
    else
      @rating = current_user.ratings.new
      @rating.experience_id = @experience.id
      @wished = current_user.wishlisted_experiences.include? @experience
      @wishlist = @experience.wishlists.find_by(user: current_user)
      flash[:alert] = "Une erreur s'est produite."
      render "experiences/show"
    end
  end

  private

  def rating_params
    params[:rating][:experience_id] = params[:experience_id] if params[:rating].present?
    params.require(:rating).permit(:user_id, :experience_id, :rating, :review)
  end
end
