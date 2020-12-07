class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :guests
  has_many :votes
  has_many :trips
  has_many :comments
  has_many :tasks
  has_many :items

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :send_welcome_email

  def all_trips
    alltrips = trips_i_own(self) + guest_of_trips(self)

    # sorting
    alltrips_asc = alltrips.sort_by do |trip|
      trip.start_date
    end
    alltrips_asc.reverse
  end

  def trips_i_own(user)
    user.trips
  end

  def guest_of_trips(user)
    user.guests.map do |guest|
      guest.trip
    end
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
