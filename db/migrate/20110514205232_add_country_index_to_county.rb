class AddCountryIndexToCounty < ActiveRecord::Migration
  def self.up
    add_index :counties, :country_id
  end

  def self.down
    remove_index :counties, :country_id
  end
end
