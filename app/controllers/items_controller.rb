class ItemsController < ApplicationController
  # TODO: this authenticate_user! should only happened on `applications_controller`
  before_action :authenticate_user!
  before_action :set_trip, only: [:new, :create]

  # TODO: this should be an API flow instead
  # create an api that your front-end will consume
  # /items.json => show all items in your db in json
  # your stimulus controller will be way simpler
  def index
    # status filter function
    if params[:category].present?
      # QN: why need to chain both search fns?
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

  # TODO: no authorization?
  def new
    @item = Item.new(category: params[:category])
    if @item.category == 'Flight'
      @flight_detail = FlightDetail.new
    end

    # render "items/_form_#{params[:category]}"
    render partial: "items/form_#{params[:category]}", locals: {trip: @trip, item: @item, flight_detail: @flight_detail}
  end

  # TODO: no authorization?
  def create
    @item = Item.new(item_params)
    # @item.category = params[:category]
    @item.user = current_user
    @item.trip = @trip
    @item.save!
    redirect_to trip_path(@trip)
  end

  private

  # QN: we're in items_controller but we're authorizing trip?
  def set_trip
    @trip = Trip.find(params[:trip_id])
    authorize @trip
  end

  def item_params
    params.require(:item).permit(:category, :start_date, :end_date, :name, :address, :price, :url)
  end
end
