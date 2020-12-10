class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom, only: :show

  def show
    # @chatroom = Chatroom.find(params[:trip_id])
    # authorize @chatroom
    @trip = Trip.find(params[:trip_id])
    @message = Message.new
  end

  def set_chatroom
    @chatroom = Chatroom.find_by(trip_id: params[:trip_id])
    authorize @chatroom
  end
end
