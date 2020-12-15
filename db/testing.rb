require "open-uri"
require 'json'

url = 'https://randomuser.me/api/'
user_serialized = open(url).read
user = JSON.parse(user_serialized)
puts "#{user['results'].first["picture"]["large"]}"
