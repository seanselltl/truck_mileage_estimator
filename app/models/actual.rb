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
    where("ST_DWithin(origin, ST_GeomFromText('point(#{olon} #{olat})'),#{radius})").
    where("ST_DWithin(destination, ST_GeomFromText('point(#{dlon} #{dlat})'),#{radius})").
    select(
      "actuals.*, (ST_Distance(origin,ST_GeomFromText('point(#{olon} #{olat})')) + ST_Distance(destination,ST_GeomFromText('point(#{dlon} #{dlat})'))) as distance"
    ).order("distance asc")
  }

  before_validation :set_direct_miles

  def set_direct_miles
    self.direct_miles = Geocoder::Calculations.distance_between(
      coordinates(:origin), coordinates(:destination)
    ).to_i
  end

  # this is to deal with heroku's beta support of postgis
  # things don't seem to work so smoothly with active record
  # so i'm setting the spacial columns directly

  after_commit :update_spacial_columns
  def update_spacial_columns
    ActiveRecord::Base.connection.execute(
      "update \"actuals\" set \"origin\" = \'point(#{origin_longitude} #{origin_latitude})\', \"destination\" = \'point(#{destination_longitude} #{destination_latitude})\' where \"actuals\".\"id\" = #{id}"
    )
  end  

  def estimate
    @estimate ||= begin
      Estimate.new(
        attributes.slice("origin_latitude", "origin_longitude", "destination_latitude", "destination_longitude")
      )
    end
  end

  def actual_to_direct_mile_ratio
    miles / direct_miles.to_f
  end

end