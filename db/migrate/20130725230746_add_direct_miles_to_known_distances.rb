class AddDirectMilesToKnownDistances < ActiveRecord::Migration
  def change
    add_column :known_distances, :direct_miles, :integer
  end
end
