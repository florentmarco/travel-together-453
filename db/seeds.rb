# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "faker"
require "date"
require "open-uri"

puts "Deleting databases"
Trip.destroy_all
User.destroy_all

puts "Creating users"
owner1 = User.new(
  email: "owner1@gmail.com",
  password: '111111',
  name: 'owner1'
)
owner1.save

owner2 = User.new(
  email: "owner2@gmail.com",
  password: '111111',
  name: "owner2"
)
owner2.save

puts "Creating trip"


10.times do 
  start_date = Date.today + rand(10..100)
  end_date = start_date + 5
  name = Faker::Address.country
  
  user_id_array = []
  User.all.each do |user|
    user_id_array << user.id
  end

  trip = Trip.new(
    name: name + ' trip',
    location: name,
    start_date: start_date,
    user_id: user_id_array.sample,
    end_date: end_date 
  )
  trip.save

end

puts "Trips created"





