class AddMilesToKnownDistances < ActiveRecord::Migration
  def change
    add_column :known_distances, :miles, :integer
  end
end
