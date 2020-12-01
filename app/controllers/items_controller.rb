class ItemsController < ApplicationController
  before_action :set_trip, only: [:new, :create]

  def new
    @item = Item.new(category: params[:category])
    if @item.category == 'flight'
     @flight_detail = FlightDetail.new
   end

    # render "items/_form_#{params[:category]}"
    render partial: "items/form_#{params[:category]}", locals: {trip: @trip, item: @item, flight_detail: @flight_detail}
  end

  def create
    @item = Item.new(item_params)
    # @item.category = params[:category]
    @item.user = current_user
    @item.trip = @trip
    @item.save!
    redirect_to trip_path(@trip)

  end

  private

  def set_trip
    @trip = Trip.find(params[:trip_id])
    authorize @trip
  end

  def item_params
    params.require(:item).permit(:category, :start_date, :end_date, :name, :address, :price, :url)
  end
end
