class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def index

    @trips = policy_scope(Trip).order(start_date: :desc)
  end

  def show
    @item = Item.new
  end

  def new
    @trip = Trip.new
    authorize @trip
  end

  def create
    @trip = Trip.new(trip_params)
    @user = User.find(current_user.id)
    @trip.user = @user
    authorize @trip

    if @trip.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @trip.update(trip_params)
    redirect_to trip_path(@trip)
  end

  def destroy
    @trip.destroy
    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :location, :name)
  end

  def set_trip
    @trip = Trip.find(params[:id])
    authorize @trip
  end
end
