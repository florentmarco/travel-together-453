class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    # record.trip.guests.include?(user) || record.trip.user == user
    # record.user == user
    guests = record.trip.guests.map do |guest|
      guest.user
    end

    guests.include?(user) || record.trip.user == user
  end

  def new?
    record.trip.guests.include?(user) || record.trip.user == user
  end

  def update_to_booked?
    record.trip.user == user
  end

  def create?
    guests = record.trip.guests.map do |guest|
      guest.user
    end

    guests.include?(user) || record.trip.user == user
  end

  def destroy?
    record.user == user || record.trip.user == user
  end

  def form?
    true
  end
end
