class Actual < ActiveRecord::Base
  include Coordinated

  validates :origin_latitude, inclusion: { in: -90..90 }
  validates :origin_longitude, inclusion: { in: -180..180 }
  validates :destination_latitude, inclusion: { in: -90..90 }
  validates :destination_longitude, inclusion: { in: -180..180 }
  validates :miles, numericality: { greater_than_or_equal_to: 0 }
  validates :direct_miles, numericality: { greater_than_or_equal_to: 0 }

  scope :like, -> (origin_coordinates, destination_coordinates, radius=50000) {
    olat, olon = [0,1].collect { |n| origin_coordinates[n] }
    dlat, dlon = [0,1].collect { |n| destination_coordinates[n] }
    where("ST_DWithin(origin, 'point(#{olon} #{olat})',#{radius})").
    where("ST_DWithin(destination, 'point(#{dlon} #{dlat})',#{radius})").
    select(
      "actuals.*, (ST_Distance(origin,'point(#{olon} #{olat})') + ST_Distance(destination,'point(#{dlon} #{dlat})')) as distance"
    ).order("distance asc")
  }

  before_validation :set_direct_miles
  before_validation :set_origin
  before_validation :set_destination

  def set_direct_miles
    self.direct_miles = Geocoder::Calculations.distance_between(
      coordinates(:origin), coordinates(:destination)
    ).to_i
  end

  def set_origin
    self.origin = point(origin_longitude, origin_latitude)
  end

  def set_destination
    self.destination = point(destination_longitude, destination_latitude)
  end

  def point(longitude, latitude)
    RGeo::Geographic.spherical_factory(srid: 4326).point(longitude, latitude)
  end

  def estimated_distance
    @estimated_distance ||= begin
      EstimatedDistance.new(
        attributes.slice("origin_latitude", "origin_longitude", "destination_latitude", "destination_longitude")
      )
    end
  end

  def actual_to_direct_mile_ratio
    miles / direct_miles.to_f
  end

end