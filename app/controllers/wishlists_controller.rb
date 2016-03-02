class WishlistsController < ApplicationController

  def index
    @wishlists = policy_scope(Wishlist)
  end

  def create
    @wishlist = current_user.wishlists.new()
    @wishlist.experience = Experience.find(params[:experience_id])
    authorize(@wishlist)

    if @wishlist.save
      @wished = true
      respond_to do |format|
        format.html { redirect_to experience_path(@wishlist.experience) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'experiences/show' }
        format.js  # <-- idem
      end
    end
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])
    authorize(@wishlist)
    @wishlist.destroy
    @wished = false
    @experience = @wishlist.experience
    respond_to do |format|
      format.html { redirect_to @experience }
      format.js
    end

  end

  private

  def wishlist_params
    params[:wishlist][:experience_id] = params[:experience_id] if params[:wishlist]
    params.require(:wishlist).permit(:user_id, :experience_id)
  end
end



