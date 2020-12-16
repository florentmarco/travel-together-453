module ApplicationHelper
  # unsplash api
  def get_trip_pic(trip, api_key)
    url = "https://api.unsplash.com/search/photos?page=1&query=#{trip}&client_id=#{api_key}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    user["results"].first["urls"]["raw"]
  end

  def get_accommodation_pic(accommodation, api_key)
    url = "https://api.unsplash.com/search/photos?page=1&query=#{accommodation}&client_id=#{api_key}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    user["results"].first["urls"]["raw"]
  end

  def get_activity_pic(activity, api_key)
    url = "https://api.unsplash.com/search/photos?page=1&query=#{activity}&client_id=#{api_key}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    user["results"].first["urls"]["raw"]
  end
end
