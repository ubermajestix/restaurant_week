class CreateRestaurants < ActiveRecord::Migration
  def self.up
    create_table :restaurants do |t|
      t.string :name
      t.string :url
      t.string :reservation_url
      t.string :city
      t.string :street
      t.string :zip
      t.string :state
      t.string :menu_url
      t.integer :menu_id
      t.string :cuisine
      t.string :phone_number
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end

  def self.down
    drop_table :restaurants
  end
end
