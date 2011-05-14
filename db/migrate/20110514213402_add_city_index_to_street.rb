class AddCityIndexToStreet < ActiveRecord::Migration
  def self.up
    add_index :streets, :city_id
  end

  def self.down
    remove_index :streets, :city_id
  end
end
