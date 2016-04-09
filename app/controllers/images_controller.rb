class ImagesController < ApplicationController
  def get_gps
    authorize(:images, :get_gps?)
    ids = ImageDataService.new()
    @address = ids.get_gps_from_id(params[:public_id])
    @address &&= Geocoder.search(@address).first
    @address &&= @address.formatted_address
    respond_to do |format|
      format.js
    end
  end
end
