namespace :export do
  task :estimates => :environment do
    CSV.open(Rails.root.join("db","exports","exports.csv"),"wb") do |csv|
      csv << ["id","actual_miles","estimated_miles","error","map_url"]
      processed = 0
      Actual.where(id: Actual.pluck(:id).sample(1000)).each do |actual|
        next unless actual.estimate.valid?
        csv << [
          actual.id,
          actual.miles,
          actual.estimate.miles,
          actual.estimate.miles - actual.miles, 
          actual.estimate.map_url
        ]
        if (processed += 1) % 1 == 0
          puts "processed #{processed}"
        end
      end
    end
  end
end