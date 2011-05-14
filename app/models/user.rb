# == Schema Information
# Schema version: 20110514154741
#
# Table name: users
#
#  id         :integer         not null, primary key
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessible :email, :pits
    has_many :pits
end
