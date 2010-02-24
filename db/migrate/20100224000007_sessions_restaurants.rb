class SessionsRestaurants < ActiveRecord::Migration
  def self.up
    create_table :sessions_restaurants, :id => false do |t|
      t.column :session_id, :integer
      t.column :restaurant_id, :integer
      t.timestamps
    end
  end

  def self.down
  end
end
