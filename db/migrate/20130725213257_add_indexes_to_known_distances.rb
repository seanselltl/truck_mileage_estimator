class AddIndexesToKnownDistances < ActiveRecord::Migration
  def change
    add_index :known_distances, :origin_latitude
    add_index :known_distances, :origin_longitude
    add_index :known_distances, :destination_latitude
    add_index :known_distances, :destination_longitude
  end
end
