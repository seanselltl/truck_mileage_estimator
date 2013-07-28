namespace :seed do
  task :actuals => :environment do
    processed = 0
    CSV.foreach(Rails.root.join("db","seeds","actuals.csv"), headers: true) do |row|
      attributes = Hash[row.headers.collect { |h| [h, row[h]] }]
      unless Actual.where(attributes).any?
        Actual.create!(Hash[row.headers.collect { |h| [h, row[h]] }])
      end
      puts "loaded #{processed}" if (processed += 1) % 1000 == 0
    end
  end
end