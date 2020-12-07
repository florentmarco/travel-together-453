require 'json'
require 'open-uri'

class TripsController < ApplicationController
  # TODO: can remove the line below if we have the whitelisting on application_controller
  before_action :authenticate_user!
  before_action :set_trip, only: [:show,  :edit, :update, :destroy, :regenerate_invite_link]

  def index
    # get array of trips current user created (see TripPolicy)
    @trips_i_own = policy_scope(Trip)
    @trips = policy_scope(Trip).order(start_date: :desc)

    # TODO: remove all commented out codes
    #@trips.each do |trip|
    #place_api(trip.location)
    #end

    # TODO: create an instance method in user.rb instead for this
    # e.g. current_user.guest_trips
    # get array of trips instance that current user is a guest of
    @guest_of_trips = current_user.guests.map do |guest|
      guest.trip
    end

    # TODO: create an instance method in user.rb instead for this
    # combined with the sorting on line 32
    # e.g. current_user.all_trips
    @alltrips = (@trips_i_own + @guest_of_trips)

    # all trips sorted in ascending order
    @alltrips_asc = @alltrips.sort_by do |trip|
      trip.start_date
    end

    # TODO: refactor this
    # all trips sorted in descending order
    @trips = @alltrips_asc.reverse
  end

  def show
    # get array of trips instance that current user is a guest of
    # TODO: create an instance method in user.rb instead for this
    @guests_trip_arr = current_user.guests.map do |guest|
      guest.trip
    end

    # TODO: i think chatrooms should have it's own page
    @message = Message.new

    # TODO: this should be checked via pundit policy instead
    # allow trip owner to enter
    if @trip.user == current_user
      @trip

    # allow existing guests to enter
    elsif @guests_trip_arr.include?(@trip)
      @trip

    # allow users that have invite link to enter
    # TODO: ideally this shouldn't happened in this action
    # create a guest_controller instead
    elsif params[:token] == @trip.invite_token
      @guest = Guest.new
      @guest.trip = @trip
      @guest.user = current_user
      @guest.save
      @trip
    else
      redirect_to trips_path
    end
  end

  def regenerate_invite_link
    @trip.update(invite_token: rand(99999999))
    redirect_to trip_path(@trip)
  end

  def email
   skip_authorization
   # TODO: we should retrieve all of this from the trip instance instead
   token = params[:token]
   subject=params[:subject]
   user = params[:email]
   trip_id = params[:trip_id]
   start_date = params[:trip_sdate]
   end_date = params[:trip_edate]
   trip_name = params[:trip_name]
   trip_user = params[:trip_user]
   TripMailer.share(token,user,subject,start_date,end_date,trip_name,trip_user).deliver
   redirect_to trip_path(trip_id), notice: "Email successfully sent"
  end

  def new
    @trip = Trip.new
    authorize @trip
  end

  def create
    @trip = Trip.new(trip_params)
    # TODO: no need to do this. just use
    # @trip.user = current_user instead
    @user = User.find(current_user.id)
    @trip.user = @user
    # TODO: can find a better gem for this instead
    @trip.invite_token = rand(99999999)
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
    # TODO: no authorize?
    @trip.update(trip_params)
    redirect_to trip_path(@trip)
  end

  def destroy
    # TODO: no authorize?
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

  # TODO: remove this if not used anymore
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
