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

Factory.define :user do |user|
  user.email "test@test.com"
end

Factory.define :county do |county|
  county.name       "Bucharest"
  county.association    :country
end

Factory.define :city do |city|
  city.name         "Bucharest"
  city.association  :county
end

Factory.define :street do |street|
  street.name         "Strada Gheorghieni"
  street.association  :city
end