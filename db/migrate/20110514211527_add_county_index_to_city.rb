class AddCountyIndexToCity < ActiveRecord::Migration
  def self.up
    add_index :cities, :county_id
  end

  def self.down
    remove_index :cities, :county_id
  end
end
