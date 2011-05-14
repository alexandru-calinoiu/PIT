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

  attr_accessor :city, :street, :county, :country
  attr_accessible :latitude, :longitude, :user, :address

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
    country = Country.new(:name => self.country) if country.nil?

    country.save

    county = country.counties.first(:conditions => "name = '#{self.county}'")
    country.counties.create(:name => self.county) if county.nil?

    country.save
  end
end
