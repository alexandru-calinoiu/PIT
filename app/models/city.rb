class City < ActiveRecord::Base
  belongs_to :county
  has_many :streets

  validates_presence_of :name
end
