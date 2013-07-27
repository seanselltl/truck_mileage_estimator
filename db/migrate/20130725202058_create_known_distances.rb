class CreateKnownDistances < ActiveRecord::Migration
  def change
    create_table :known_distances do |t|

      t.timestamps
    end
  end
end
