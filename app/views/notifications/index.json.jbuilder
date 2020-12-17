json.array! @notifications do |notification|
  # json.id notification.id
  json.user notification.user.name
  # json.recipient notification.recipient.name
  json.trip notification.trip.name
  json.url trip_chatroom_path(notification.trip.id, Chatroom.find_by(trip_id: notification.trip.id))
end
