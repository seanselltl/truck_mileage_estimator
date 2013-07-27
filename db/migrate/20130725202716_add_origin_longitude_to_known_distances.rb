class AddOriginLongitudeToKnownDistances < ActiveRecord::Migration
  def change
    add_column :known_distances, :origin_longitude, :decimal
  end
end
