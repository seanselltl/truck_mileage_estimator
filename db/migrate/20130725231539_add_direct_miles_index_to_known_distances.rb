class AddDirectMilesIndexToKnownDistances < ActiveRecord::Migration
  def change
    add_index :known_distances, :direct_miles
  end
end
