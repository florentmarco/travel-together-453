class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @trip = Trip.find(params[:trip_id])
    @message = Message.new(message_params)
    @message.trip = @trip
    @message.user = current_user
    authorize @message

    if @message.save
      redirect_to trip_path(@trip, anchor: "message-#{@message.id}")
    else
      render "trip/show"
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
