class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:new, :create, :update, :update_to_booked, :form]
  before_action :set_item, only: [:edit, :update, :destroy]

  def index
    # category filter
    if params[:category].present?
      @category_filter = policy_scope(Item).search_by_category(params[:category]).search_by_id(params[:trip_id])
    else
      @category_filter = policy_scope(Item).search_by_id(params[:trip_id])
    end

    # status filter
    if params[:status].present? || params[:status] == ""
      @status_filter = @category_filter.search_by_status(params[:status]).search_by_id(params[:trip_id])
    else
      @status_filter = @category_filter
    end

    # itinerary filter
    if params[:category] == "Flight Accommodation Activity"
      @itinerary_filter = @status_filter.sort_by { |item| item.start_date }
    else
      @itinerary_filter = @status_filter
    end

    @items = @itinerary_filter

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
    @item.user = current_user
    @item.trip = @trip
    if @item.category == 'Flight'
      @flight_detail = FlightDetail.new(flight_detail_params)
      @flight_detail.item = @item
      @flight_detail.save
    end
    if @item.save
      redirect_to trip_path(@trip)
    else
      render :new
    end

    authorize @item
  end

  def update_to_booked
    @item = Item.find(params[:item_id])
    @item.update(status: "Booked")

    authorize @item
  end

  def edit
    @flight_detail = @item.flight_detail

    authorize @item
  end

  def update
    @item.update(item_params)
    if @item.flight_detail.nil?
    else
      @flight_detail = @item.flight_detail
      @flight_detail.update(flight_detail_params)
    end
    redirect_to trip_path(@trip)

    authorize @item
  end

  def destroy
    @item.destroy
    redirect_to trip_path(@trip)

    authorize @item
  end

  private

  def set_item
    @item = Item.find(params[:id])
    @trip = @item.trip
  end

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
