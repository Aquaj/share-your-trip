class WishlistsController < ApplicationController

  def index
    @wishlists = Wishlist.all
  end

  def create
    @wishlist = current_user.wishlists.new(wishlist_params)
    @wishlist.save
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])
    @wishlist.destroy
  end

  private

  def wishlist_params
    params[:wishlist][:experience_id] = params[:experience_id] if params[:wishlist]
    params.require(:wishlist).permit(:user_id, :experience_id)
  end



end

