class CreateEstimatedDistances < ActiveRecord::Migration
  def change
    create_table :estimated_distances do |t|
      t.decimal :origin_latitude
      t.decimal :origin_longitude
      t.decimal :destination_latitude
      t.decimal :destination_longitude
      t.integer :miles

      t.timestamps
    end
  end
end
