class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @chatroom.trip = @trip
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    @message.trip_id = params[:trip_id]
    authorize @message

    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "message", locals: { message: @message })
      )

      (trip_members - [current_user]).each do |recipient|
        @notification = Notification.new(
          recipient_id: recipient.id,
          user_id: current_user.id,
          trip_id: @message.trip_id
        )
        authorize @notification
        @notification.save!
      end

      # redirect_to trip_path(@trip, anchor: "message-#{@message.id}")
    else
      render "trip/show"
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def trip_members
    trip = Trip.find(params[:trip_id])
    guest = Guest.find_by(trip_id: trip.id)
    [User.find(trip.user_id)] + [User.find(guest.user_id)]
  end
end
