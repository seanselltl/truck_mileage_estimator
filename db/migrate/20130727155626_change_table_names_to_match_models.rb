class ChangeTableNamesToMatchModels < ActiveRecord::Migration
  def change
    rename_table :known_distances, :comparables
    rename_table :estimated_distances, :estimates
  end
end
