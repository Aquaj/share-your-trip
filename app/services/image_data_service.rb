class ImageDataService
  def get_gps_from_id(public_id)
    exif = Cloudinary::Api.resource(public_id, exif: true)["exif"]
    lat = sexagesimal_to_decimal(exif["GPSLatitude"], exif["GPSLatitudeRef"])
    long = sexagesimal_to_decimal(exif["GPSLongitude"], exif["GPSLongitudeRef"])
    return lat, long
  end

private

  def sexagesimal_to_decimal(coord, orientation)
    gps = coord.split(", ").map do |frac|
      frac.split("/").map(&:to_f).reduce(&:/)
    end
    dec = gps[0]+((gps[1]*60+gps[2])/3600)
    return -dec if orientation == "S" || orientation == "W"
    dec
  end
end
