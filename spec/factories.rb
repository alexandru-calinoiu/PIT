require "factory_girl_rails"

Factory.define :pit do |user|
  user.latitude     44
  user.longitude    22
  user.address      "str. Semaforului, nr. 23"
end

Factory.define :country do |country|
  country.name     "Romania"
end