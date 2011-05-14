# == Schema Information
# Schema version: 20110514203958
#
# Table name: counties
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class County < ActiveRecord::Base
  validates_presence_of :name

  belongs_to :country
  has_many :cities
end




