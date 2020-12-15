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
require 'json'


puts "Deleting databases"
Trip.destroy_all
User.destroy_all

# get random picture from api
def get_random_pic
  url = 'https://randomuser.me/api/'
  user_serialized = open(url).read
  user = JSON.parse(user_serialized)
  user['results'].first["picture"]["large"]
end

# attach random profile pic to user and upload to cloudinary
def use_cloudinary(user, pic_file)
  file = URI.open(pic_file)
  user.avatar.attach(io: file, filename: 'nes.png', content_type: 'image/png')
end

puts "Creating users"
owner1 = User.new(
  email: "owner1@example.com",
  password: '111111',
  name: 'owner1'
)
use_cloudinary(owner1, get_random_pic)
owner1.save!
puts "#{owner1.name} created"

owner2 = User.new(
  email: "owner2@example.com",
  password: '111111',
  name: "owner2"
)
use_cloudinary(owner2, get_random_pic)
owner2.save!
puts "#{owner2.name} created"

guest1 = User.new(
  email: "guest1@example.com",
  password: '111111',
  name: "guest1"
)
use_cloudinary(guest1, get_random_pic)
guest1.save!
puts "#{guest1.name} created"

guest2 = User.new(
  email: "guest2@example.com",
  password: '111111',
  name: "guest2"
)
use_cloudinary(guest2, get_random_pic)
guest2.save!
puts "#{guest2.name} created"

guest3 = User.new(
  email: "guest3@example.com",
  password: '111111',
  name: "guest3"
)
use_cloudinary(guest3, get_random_pic)
guest3.save!
puts "#{guest3.name} created"

guest4 = User.new(
  email: "guest4@example.com",
  password: '111111',
  name: "guest4"
)
use_cloudinary(guest4, get_random_pic)
guest4.save!
puts "#{guest4.name} created"

guest5 = User.new(
  email: "guest5@example.com",
  password: '111111',
  name: "guest5"
)
use_cloudinary(guest5, get_random_pic)
guest5.save!
puts "#{guest5.name} created"


puts "Creating past trips"

10.times do
  start_date = Date.today - rand(10..100)
  end_date = start_date + 5
  name = ['Kerala', 'France', 'Nepal', 'New Zealand', 'Canada', 'Indonesia', 'Australia']

  user_id_array = []
  User.all.each do |user|
    user_id_array << user.id
  end
  trip_name = name.sample
  newtrip = Trip.new(
    name: trip_name + 'Trip',
    location: trip_name,
    start_date: start_date,
    user_id: user_id_array.sample,
    end_date: end_date,
    invite_token: rand(999999999)
  )
  newtrip.save!
  puts
  puts "#{newtrip.name.upcase}"

  15.times do
    newitem = Item.new(
      category: ["Flight", "Accommodation", "Activity"].sample,
      status: ["Pending", "Approved", "Booked"].sample
      )
    newitem.trip = newtrip
    newitem.user = newtrip.user
    newitem.price = rand(0..250)
    newitem.url = 'www.sample.com'

    case newitem.category
    when "Accommodation"
      newitem.name = Faker::Hipster.word
      newitem.start_date = newitem.trip.start_date
      newitem.end_date = newitem.trip.end_date
    when "Activity"
      newitem.name = Faker::Restaurant.name
      newitem.address = Faker::Address.street_address
      newitem.start_date = newitem.trip.start_date + rand(0..2)
    end

    if newitem.category == 'Flight'
      newitem.start_date = newitem.trip.start_date
      newitem.end_date = newitem.trip.end_date
      fd = FlightDetail.new(
        airline: ['Air Asia', 'Singapore Airline', 'Scoot'].sample,
        flight_number: ['AA', 'SG', 'SC'].sample + rand(100..999).to_s,
        departure_airport: 'SIN',
        arrival_airport: ['AAA', 'BBB', 'CCC', 'DDD', 'EEE'].sample
        )
      fd.item = newitem
      fd.save!
    end

    newitem.save!

    puts "#{newitem.category} - #{newitem.status}"
  end
end


puts "Creating trip and items"


10.times do
  start_date = Date.today + rand(10..100)
  end_date = start_date + 5
  name = ['Kerala', 'France', 'Nepal', 'New Zealand', 'Canada', 'Indonesia', 'Australia']

  user_id_array = []
  User.all.each do |user|
    user_id_array << user.id
  end
  trip_name = name.sample
  newtrip = Trip.new(
    name: trip_name + 'Trip',
    location: trip_name,
    start_date: start_date,
    user_id: user_id_array.sample,
    end_date: end_date,
    invite_token: rand(999999999)
  )
  newtrip.save!
  puts
  puts "#{newtrip.name.upcase}"

  # add 3x guests to each trip
  3.times do
    guest = Guest.new
    guest.user = [guest1, guest2, guest3, guest4, guest5].sample
    guest.trip = newtrip
  end

  15.times do
    newitem = Item.new(
      category: ["Flight", "Accommodation", "Activity"].sample,
      status: ["Pending", "Approved", "Booked"].sample
      )
    newitem.trip = newtrip
    newitem.user = newtrip.user
    newitem.price = rand(0..250)
    newitem.url = 'www.sample.com'

    case newitem.category
    when "Accommodation"
      newitem.name = Faker::Hipster.word
      newitem.start_date = newitem.trip.start_date
      newitem.end_date = newitem.trip.end_date
    when "Activity"
      newitem.name = Faker::Restaurant.name
      newitem.address = Faker::Address.street_address
      newitem.start_date = newitem.trip.start_date + rand(0..2)
    end

    if newitem.category == 'Flight'
      newitem.start_date = newitem.trip.start_date
      newitem.end_date = newitem.trip.end_date
      fd = FlightDetail.new(
        airline: ['Air Asia', 'Singapore Airline', 'Scoot'].sample,
        flight_number: ['AA', 'SG', 'SC'].sample + rand(100..999).to_s,
        departure_airport: 'SIN',
        arrival_airport: ['AAA', 'BBB', 'CCC', 'DDD', 'EEE'].sample
        )
      fd.item = newitem
      fd.save!
    end

    newitem.save!

    puts "#{newitem.category} - #{newitem.status}"
  end
end

puts "Trips and items created"
