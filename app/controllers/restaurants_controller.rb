class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all(:conditions=>["lat != NULL and lng != NULL"])
  end
  
end
