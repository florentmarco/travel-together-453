# require "open-uri"
# require 'json'

# url = 'https://randomuser.me/api/'
# user_serialized = open(url).read
# user = JSON.parse(user_serialized)
# puts "#{user['results'].first["picture"]["large"]}"

require "unsplash"

# photo = Unsplash::Photo.find("tAKXap853rY")

# search_results = Unsplash::Photo.search("cats")
photo = Unsplash::Photo.find("tAKXap853rY")
p photo
