class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:new, :create, :update, :update_to_booked, :form]

  def index
    # status filter function
    if params[:category].present?
      @category_filter = policy_scope(Item).search_by_category(params[:category]).search_by_id(params[:trip_id])
    else
      @category_filter = policy_scope(Item).search_by_id(params[:trip_id])
    end

    if params[:status].present? || params[:status] == ""
      @status_filter = @category_filter.search_by_status(params[:status]).search_by_id(params[:trip_id])
    else
      @status_filter = @category_filter
    end
    @items = @status_filter

    render partial: 'items/item', collection: @items
  end

  def new
    authorize @trip
  end

  def form
    @item = @trip.items.new(category: params[:category])
    authorize @item
    if @item.category == 'Flight'
      @flight_detail = FlightDetail.new
    end

    render partial: "items/form_#{params[:category]}", locals: {trip: @trip, item: @item, flight_detail: @flight_detail}
  end

  def create
    @item = Item.new(item_params)
    # @item.category = params[:category]
    @item.user = current_user
    @item.trip = @trip
    @item.save!
    if @item.category == 'Flight'
      @flight_detail = FlightDetail.new(flight_detail_params)
      @item.flight_detail = @flight_detail
    end
    redirect_to trip_path(@trip)
    authorize @item
  end

  def update_to_booked
    @item = Item.find(params[:item_id])
    @item.update(status: "Booked")

    authorize @item
  end

  private

  def set_trip
    @trip = Trip.find(params[:trip_id])
    # authorize @trip
  end

  def item_params
    params.require(:item).permit(:category, :start_date, :end_date, :name, :address, :price, :url, :flight_detail)
  end

  def flight_detail_params
    params.require(:item).require(:flight_detail).permit(:airline, :flight_number, :departure_airport, :arrival_airport)
  end
end
