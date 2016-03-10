module RoadmapsHelper
  def title(roadmap)
    start = "Mon voyage "

    # Traded sliiiiight amount of performance/memory
    # to decrease significantly Geocoding queries.
    cities = []
    countries = []
    continents = []

    unless roadmap.start_destination.nil?
      cities << roadmap.start_city
      countries << roadmap.start_country
      continents << roadmap.start_continent
    end

    unless roadmap.end_destination.nil?
      cities << roadmap.end_city
      countries << roadmap.end_country
      continents << roadmap.end_continent
    end

    # in City (if everything happens in same city)
    cities += roadmap.activities.map(&:city)
    return "#{start} à #{cities.first}" if cities.uniq.length == 1

    # in Country (if everything happens in same country)
    countries += roadmap.activities.map(&:country)
    return "#{start} en #{countries.first}" if countries.uniq.length == 1

    # in Continent (if everything hapens on same continent)
    # Continent1 - Continent2 (if everything happens between two)
    # around the world (if more than two continents are involved)
    continents += roadmap.activities.map(&:continent)
    continents.uniq!
    return "#{start} en #{continents.first}" if continents.length == 1
    return "#{start} #{continents.first} - #{continents.last}" if continents.length == 2
    return "#{start} autour du globe"
  end

  # Based on Rails Helper content_tag
  # Behaves like content_tag in every way
  # but does not build HTML tags around empty block.
  def flexible_content_tag(name, content_or_options_with_block = nil, options = nil, escape = true, &block)
    if block_given?
      options = content_or_options_with_block if content_or_options_with_block.is_a?(Hash)
      content = capture(&block)
      content_tag_string(name, content, options, escape) if content.present?
    else
      content_tag_string(name, content_or_options_with_block, options, escape)
    end
  end


end
