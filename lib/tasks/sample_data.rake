require 'faker'

def make_pits
  lat_org = 43.723475
  long_org = 21.73645

  1000.times do |n|
    pit_latitude = lat_org + rand(4) + rand(100000)/100000.0
    pit_longitude = long_org + rand(6) + rand(100000)/100000.0

    user = User.create!(:email => "test-#{n+1}@agilefreaks.com")
    Pit.create(:latitude => pit_latitude, :longitude => pit_longitude, :user_id => user.id)
  end
end

namespace :db do
  desc 'Fill database with sample data'
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_pits()
  end
end
