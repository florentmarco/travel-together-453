class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:new, :create, :update, :update_to_booked]
  before_action :set_item, only: [:edit, :update, :destroy]

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
    @item = @trip.items.new(category: params[:category])
    if @item.category == 'Flight'
      @flight_detail = FlightDetail.new
      @flight_detail.airline = 'TT'
      @flight_detail.save
    end

    # render "items/_form_#{params[:category]}"
    render partial: "items/form_#{params[:category]}", locals: {trip: @trip, item: @item, flight_detail: @flight_detail}
    authorize @item
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

  def edit
    @flight_detail = @item.flight_detail
    render partial: "items/form_#{@item.category}", locals: {trip: @trip, item: @item, flight_detail: @flight_detail}

    authorize @item
  end

  def update
    @item.update(item_params)
    @flight_detail = @item.flight_detail
    @flight_detail.update(flight_detail_params)
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
