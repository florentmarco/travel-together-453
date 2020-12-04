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
owner1.save!

owner2 = User.new(
  email: "owner2@gmail.com",
  password: '111111',
  name: "owner2"
)
owner2.save!

puts "Creating trip and items"


10.times do
  start_date = Date.today + rand(10..100)
  end_date = start_date + 5
  name = Faker::Address.country

  user_id_array = []
  User.all.each do |user|
    user_id_array << user.id
  end

  newtrip = Trip.new(
    name: name + ' trip',
    location: name,
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
