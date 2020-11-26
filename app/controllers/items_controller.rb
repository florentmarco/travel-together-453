class ItemsController < ApplicationController
  before_action :set_trip, only: [:create]

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    @item.trip = @trip
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
    authorize @trip
  end

  def item_params
    params.require(:trip).permit(:start_date, :end_date, :type, :name)
  end

end
