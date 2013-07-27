class Estimate < ActiveRecord::Base
  include Coordinated

  validates :origin_latitude, inclusion: { in: -90..90, message: "is not between -90 and 90" }
  validates :origin_longitude, inclusion: { in: -180..180, message: "is not between -180 and 180" }
  validates :destination_latitude, inclusion: { in: -90..90, message: "is not between -90 and 90" }
  validates :destination_longitude, inclusion: { in: -180..180, message: "is not between -180 and 180" }
  validates :miles, numericality: { greater_than_or_equal_to: 0 }

  before_validation :set_miles

  def set_miles
    self.miles = calculate_miles
  end

  def direct_miles
    Geocoder::Calculations.distance_between(
      coordinates(:origin), coordinates(:destination)
    ).to_i
  end

  def calculate_miles
    begin
      return nil unless actuals.any?
      (blended_actual_to_direct_mile_ratio * direct_miles).to_i
    rescue
    end
  end

  def actuals(n=4)
    @actuals ||= begin
      Actual.like(coordinates(:origin), coordinates(:destination), 100000).limit(4).to_a
    end
  end

  def blended_actual_to_direct_mile_ratio
    actuals.collect(&:actual_to_direct_mile_ratio).sum / actuals.size
  end

  def map_url
    StaticMap::Image.new({
      markers: [
        { latitude: olat, longitude: olon, color: "green", label: "1" },
        { latitude: dlat, longitude: dlon, color: "red", lable: "1" },
      ] + (actuals.collect.with_index do |c, i|
        [
          { latitude: c.olat, longitude: c.olon, color: "green", label: i + 2 },
          { latitude: c.dlat, longitude: c.dlon, color: "red", label: i + 2 }
        ]
      end.compact).flatten
    }).url
  end

end
