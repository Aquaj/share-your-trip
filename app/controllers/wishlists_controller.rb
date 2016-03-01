class WishlistsController < ApplicationController
  before_action :authorize_wishlist, only: [:edit, :update, :destroy]

  def index
    @wishlists = policy_scope(Wishlist)
  end

  def create
    @wishlist = current_user.wishlists.new(wishlist_params)
    authorize(@wishlist)
    @wishlist.save
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])
    authorize(@wishlist)
    @wishlist.destroy
  end

private

  def wishlist_params
    params[:wishlist][:experience_id] = params[:experience_id] if params[:wishlist]
    params.require(:wishlist).permit(:user_id, :experience_id)
  end
end

