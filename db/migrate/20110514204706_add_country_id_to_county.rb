class AddCountryIdToCounty < ActiveRecord::Migration
  def self.up
    add_column :counties, :country_id, :integer
  end

  def self.down
    remove_column :counties, :country_id
  end
end
