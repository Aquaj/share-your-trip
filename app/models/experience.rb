require 'uri'

class Experience < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :ratings, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :users, through: :wishlists
  has_many :activities, dependent: :destroy
  has_many :roadmaps, through: :activities

  validates :title, presence: true
  validates :category, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :photos, presence: true
  validate :valid_url

  has_attachments :photos, maximum: 3

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  after_save :cache, if: :address_changed?

  def self.search(search, experiences) # Second parameter needed to account for Pundit scope
    # TODO: Extract the three parts in respective methods.
    locate = LocationService.new
    results = experiences
    if search
      # Localization
      if !search[:address].blank?
        city = locate.city(search[:address]) # if it's not city it's a country
        if city.present? # city
          results = results.near(search[:address], 20)
        else # country
          country = locate.country(search[:address])
          results = results.select{ |e| e.country == country}
        end
      end

      # Category
      if !search[:category].blank?
        filter_category = Category.find(search[:category])
        results = results.select { |e| filter_category.with_children.include? e.category }
      end

      # Sorting/ordering
      sort = search[:sort]
      if sort == "note"
        # Best to worst // + to -
        results = results.sort { |e, f| f.average_rating - e.average_rating }
      else
        # Most recent to oldest // - to +
        results = results.sort { |e, f| e.created_at - f.created_at }
      end
    end

    results
  end

  def is_occupation?
    return !%W(Hôtel Restaurant Bar Vie\ Nocturne).include?(self.category.title)
  end

  # Not used (yet?)
  def is_reusable?
    return self.category.title == "Hôtel"
  end

  def average_rating
    if self.ratings.length > 0
      sum = self.ratings.reduce(0) { |a, r| r.rating+a }
      return sum/self.ratings.length
    else
      return 3 # Average by default not to penalize new Experiences
    end
  end

  ## City/Country/Continent
  # Returns the cached value of the property
  # if cache doesn't exist yet, builds cache
  # for all three values.
  def city
    cache if self.city_cache.nil?
    return city_cache
  end

  def country
    cache if self.country_cache.nil?
    return country_cache
  end

  def continent
    cache if self.continent_cache.nil?
    return continent_cache
  end

private

  def cache
    data = LocationService.new.full_info(address)
    update_columns(
      city_cache: data[:city],
      country_cache: data[:country],
      continent_cache: data[:continent]
    )
  end

  def valid_url
  return if self.url == nil
  uri = URI.parse(self.url)
  errors.add(:url, "n'est pas une URL valide.") unless uri.kind_of?(URI::HTTP)
  rescue URI::InvalidURIError
    errors.add(:url, "n'est pas une URL valide.")
  end
end
