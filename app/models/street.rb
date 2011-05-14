class Street < ActiveRecord::Base
  belongs_to :city
  has_many :pits

  validates_presence_of :name
end
