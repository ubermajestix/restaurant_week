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
  
  task :one do
    puts 1
  end
  
  task :two do
    puts 2
  end
  
  task :do_it => :one => :two do
    puts "doing it"
  end
  
  
end