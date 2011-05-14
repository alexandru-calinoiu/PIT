# == Schema Information
# Schema version: 20110514203958
#
# Table name: pits
#
#  id         :integer         not null, primary key
#  latitude   :float
#  longitude  :float
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  address    :string(255)
#

require "geocoder"

class Pit < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude

  belongs_to :user
  belongs_to :street

  attr_accessor :city, :street, :county, :country
  attr_accessible :latitude, :longitude, :user, :address, :street_id

  after_validation :reverse_geocode
  before_save :update_country

  reverse_geocoded_by :latitude, :longitude do |pit, results|
    if geo = results.first
      pit.country = geo.country
      pit.county = geo.county
      pit.city = geo.city
      pit.street = geo.street["stfull"]
      pit.address = geo.address
    end
  end

  private

  def update_country
    country = Country.find_by_name(self.country)
    country = Country.create(:name => self.country) if country.nil?

    if country.valid?

      county = country.counties.first(:conditions => "name = '#{self.county}'")
      county = country.counties.create(:name => self.county) if county.nil?

      country.save

      if county.valid?
        city = county.cities.first(:conditions => "name = '#{self.city}'")
        city = county.cities.create(:name => self.city) if city.nil?

        county.save

        if street.valid?
          street = city.streets.first(:conditions => "name = '#{self.street}'")
          street = city.streets.create(:name => self.street) if street.nil?

          city.save

          self.street_id = street.id
        end
      end
    end
  end
end
