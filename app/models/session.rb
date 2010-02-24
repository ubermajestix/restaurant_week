class Session < ActiveRecord::Base
  has_many :restaurants, :through => :sessions_restaurants
end
  