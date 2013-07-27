class AddOriginLatitudeToKnownDistances < ActiveRecord::Migration
  def change
    add_column :known_distances, :origin_latitude, :decimal
  end
end
