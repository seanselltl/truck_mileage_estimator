class AddDestinationLongitudeToKnownDistances < ActiveRecord::Migration
  def change
    add_column :known_distances, :destination_longitude, :decimal
  end
end
