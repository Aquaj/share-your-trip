module RoadmapsHelper
  def title(roadmap)
    locate = LocationService.new
    start = "Mon voyage "

    addresses = []

    [roadmap.start_destination, roadmap.end_destination].each do |addr|
      addresses << addr unless addr.nil?
    end

    addresses += roadmap.activities.map(&:address)

    # in City (if everything happens in same city)
    cities = addresses.map { |addr| locate.city(addr) }.uniq
    return "#{start} à #{cities.first}" if cities.length == 1

    # in Country (if everything happens in same country)
    countries = addresses.map { |addr| locate.country(addr) }.uniq
    return "#{start} en #{countries.first}" if countries.length == 1

    # in Continent (if everything hapens on same continent)
    # Continent1 - Continent2 (if everything happens between two)
    # around the world (if more than two continents are involved)
    continents = addresses.map { |addr| locate.continent(addr) }.uniq
    return "#{start} en #{continents.first}" if continents.length == 1
    return "#{start} #{continents.first} - #{continents.last}" if continents.length == 2
    return "#{start} autour du globe"
  end
end
