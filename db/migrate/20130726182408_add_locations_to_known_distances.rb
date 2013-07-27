class AddLocationsToKnownDistances < ActiveRecord::Migration
  def change
    add_column :known_distances, :origin, :point, geographic: true
    add_column :known_distances, :destination, :point, geographic: true
  end
end
