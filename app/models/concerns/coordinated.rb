module Coordinated
  extend ActiveSupport::Concern

  def origin_coordinates
    [origin_latitude, origin_longitude]
  end

  def destination_coordinates
    [destination_latitude, destination_longitude]
  end

  def coordinates(location_type)
    case location_type
    when :origin then origin_coordinates 
    when :destination then destination_coordinates
    end
  end

  def olat
    origin_latitude
  end

  def olon
    origin_longitude
  end

  def dlat
    destination_latitude
  end

  def dlon
    destination_longitude
  end

end