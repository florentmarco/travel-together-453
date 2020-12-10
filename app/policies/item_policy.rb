class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    # record.user == user
  end

  def update_to_booked?
    record.user == user
  end
end
