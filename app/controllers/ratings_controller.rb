class RatingsController < ApplicationController
    def create
      @rating = current_user.ratings.new(rating_params)
      authorize(@rating)
      if @rating.save
        redirect_to @rating.experience
      else
        @experience = @rating.experience
        render "experiences/show"
      end
  end

  private

  def rating_params
    params[:rating][:experience_id] = params[:experience_id] if params[:rating].present?
    params.require(:rating).permit(:user_id, :experience_id, :rating, :review)
  end
end
