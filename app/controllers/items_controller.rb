class ItemsController < ApplicationController
  before_action :set_trip, only: [:new, :create]

  def new
    @item = Item.new(category: params[:category])
    # render "items/_form_#{params[:category]}"
    render partial: "items/form_#{params[:category]}", locals: {trip: @trip, item: @item}
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    @item.trip = @trip
  end

  private

  def set_trip
    @trip = Trip.find(params[:trip_id])
    authorize @trip
  end

  def item_params
    params.require(:trip).permit(:start_date, :end_date, :type, :name)
  end

end
