# == Schema Information
# Schema version: 20110514183313
#
# Table name: countries
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Country < ActiveRecord::Base
  validates_presence_of :name

  has_many :counties
end
