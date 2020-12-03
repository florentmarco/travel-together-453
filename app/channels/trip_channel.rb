class TripChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    trip = Trip.find(params[:id])
    stream_for trip
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
