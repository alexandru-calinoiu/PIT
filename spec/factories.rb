require "factory_girl_rails"

Factory.define :pit do |pit|
  pit.latitude     44.4201461
  pit.longitude    26.0798653
  pit.address      "str. Semaforului, nr. 23"
  pit.country       "Romania"
end

Factory.define :country do |country|
  country.name      "Romania"
end