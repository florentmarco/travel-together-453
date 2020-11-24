class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def index
    @trips = Trip.all
  end

  def show
  end

  def edit
  end

  def update
    @trip.update(trip_params)
    redirect_to trip_path(@trip)
  end

  private

  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :location)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end

end
