class AddDestinationLatitudeToKnownDistances < ActiveRecord::Migration
  def change
    add_column :known_distances, :destination_latitude, :decimal
  end
end
