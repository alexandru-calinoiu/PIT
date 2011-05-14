# == Schema Information
# Schema version: 20110514160117
#
# Table name: pits
#
#  id         :integer         not null, primary key
#  latitude   :float
#  longitude  :float
#  created_at :datetime
#  updated_at :datetime
#  address    :string(255)
#

require "geocoder"

class Pit < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude

  attr_accessor :city, :zipcode, :county, :country

  attr_accessible :latitude, :longitude, :address
  after_validation :reverse_geocode

  reverse_geocoded_by :latitude, :longitude do |pit, results|
    if geo = results.first
      pit.country = geo.country
      pit.county = geo.county
      pit.city = geo.city
      pit.address = geo.address
    end
  end
end
