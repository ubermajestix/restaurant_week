namespace :scrape do 
  
  desc "scrape restaurant info from web"
  task :info => :environment do
    Restaurant.scrape
  end
  
  task :cuisine => :environment do
    Restaurant.match_cuisine
  end
  
  task :geocode => :environment do
    Restaurant.all.each do |r|
      r.geocode
    end
  end
  
  task :all =>[:info, :cuisine, :geocode]
  task :default => :all
  
end