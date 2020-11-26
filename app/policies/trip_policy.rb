class TripPolicy < ApplicationPolicy


  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def show?
    user && (user == record.user || user.admin)
  end

  def update?
    user && (user == record.user || user.admin)
  end

  def destroy?
    user && (user == record.user || user.admin)
  end
end
