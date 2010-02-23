class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.geocoded
  end
  
end
