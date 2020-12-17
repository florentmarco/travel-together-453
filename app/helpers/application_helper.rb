module ApplicationHelper
  # unsplash api
  def get_query_pic(item_name, api_key)
    url = "https://api.unsplash.com/search/photos?page=1&query=#{item_name}&client_id=#{api_key}"
    item_serialized = open(url).read
    item = JSON.parse(item_serialized)
    item["results"].first["urls"]["thumb"]
  end
end
