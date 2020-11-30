require 'json'
require 'open-uri'

class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def index

    @trips = policy_scope(Trip).order(start_date: :desc)
    #@trips.each do |trip|
    #place_api(trip.location)
    #end
  end

  def show
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

  #def place_api(location)
  #  url = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=#{location}&inputtype=textquery&fields=photos&key=#{ENV['PLACES_API']}"
  #  photo_serialised = open(url).read
  #  photo = JSON.parse(photo_serialised)
  #  photo_reference = photo["candidates"][0]["photos"][0]["photo_reference"]
  #  photo_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{photo_reference}&key=#{ENV['PLACES_API']}"
  #  photo_serialised = open(photo_url).read
  #end
end
#
