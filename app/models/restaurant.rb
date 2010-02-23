require 'nokogiri'
require 'cgi'
class Restaurant < ActiveRecord::Base
  
  def self.scrape
    doc = Nokogiri::HTML(`curl http://www.denver.org/denverrestaurant/Restaurants.aspx`)
    # restaurant_links = ["denverrestaurant/Menus/Menu.aspx?id=389"]
    restaurant_links = []
    
    doc.search("a").each{|a| restaurant_links << a.attribute('href').to_s if a.attribute('href').to_s.match(/Menu\.aspx\?id\=/)}
    restaurant_links.each do |link|
      r = Restaurant.new
      r.menu_url = "http://www.denver.org/#{link}"
      r.menu_id = link.scan(/(id\=)(\d+)/).first.last.to_i
      doc = Nokogiri::HTML(`curl #{r.menu_url}`)
      r.name = doc.search("div#section2contentcontainer td.h2").first.inner_html.to_s.strip
      p = doc.search("div#section2contentcontainer p").first
      r.street = p.search("span").first.inner_html
      restaurant_url = p.search("a").first
      r.url = restaurant_url.attribute("href").to_s.strip if restaurant_url
      reservation = p.search("span a").first
      r.reservation_url = reservation.attribute("href").to_s.strip if reservation
      r.city, r.state, r.zip, r.phone_number = *p.inner_html.split("\r\n").collect{|p| p.gsub!(/\W/,''); p unless p == "br"}.compact[2,4]
      puts r.inspect
      r.save!
    end
  end
  
  def self.match_cuisine
    doc = Nokogiri::HTML(`curl http://www.denver.org//denverrestaurant/MenusCuisine.aspx`)
    cuisines = []
    doc.search("div#section2contentcontainer table").each do |t|
      cuisine = t.attribute("id").to_s.gsub(/(ctl00_ContentPlaceHolder1_tbl)|(ctl00_ContentPlaceHolder1_dl)/,'')
      cuisines << cuisine unless cuisines.include?(cuisine) 
    end
    cuisines_hash = {}
    cuisines.each do |cuisine|
      cuisines_hash[cuisine] = []
      doc.search("table#ctl00_ContentPlaceHolder1_dl#{cuisine} a").each do |link|
        id_array = link.attribute("href").to_s.scan(/(id\=)(\d+)/).flatten
        puts id_array.inspect
        cuisines_hash[cuisine] << id_array.last.to_i if id_array.any?
      end
    end
    
    cuisines_hash.each_pair do |cuisine, id_array|
      id_array.each do |id|
        r = Restaurant.find_by_menu_id(id)
        r.update_attributes(:cuisine=>cuisine)
      end
    end
    
  end
  
  def geocode
    res = JSON.parse(`curl http://maps.google.com/maps/geo?q=#{self.geocode_address}&output=json&oe=utf-8`)
    puts "="*45
    puts res.inspect
    puts "="*45
    status = res["Status"]["code"].to_s
    if status == "200"
     coords = res["Placemark"].first["Point"]["coordinates"]#=>[-104.989021, 39.74223, 0]}
     puts coords.inspect
     self.update_attributes(:lat=>coords[1].to_f, :lng=>coords[0].to_f)
    end
  end
  
  def geocode_address
    CGI.escape([street, city, state, zip].join(" "))
  end
  
end
