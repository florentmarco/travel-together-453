module ApplicationHelper
  def path_for_route(path_info, trip=nil)
    case
  when path_info.match?(/trips\/\d+/)
      new_trip_item_path(trip)
    else
      new_trip_path
    end
  end
end
