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
      # redirect_to trip_path(@trip, anchor: "message-#{@message.id}")
    else
      render "trip/show"
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
