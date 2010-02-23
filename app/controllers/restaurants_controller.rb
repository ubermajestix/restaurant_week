class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all(:conditions=>["lat not null and lng not null"])
  end
  
end
