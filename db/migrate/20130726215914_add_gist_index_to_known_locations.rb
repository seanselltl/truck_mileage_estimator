class AddGistIndexToKnownLocations < ActiveRecord::Migration
  def change
    ["origin", "destination"].each do |point|
      sql = "CREATE INDEX #{point}_index ON known_distances USING GIST ( #{point} );"
      ActiveRecord::Base.connection.execute(sql)
    end
  end
end
