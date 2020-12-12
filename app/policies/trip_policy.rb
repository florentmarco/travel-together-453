class TripPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    true
  end

  def show?
    # user && (user == record.user || user.admin)
    true
  end

  def update?
    user && (user == record.user || user.admin)
  end

  def destroy?
    user && (user == record.user || user.admin)
  end

  def regenerate_invite_link?
    true
  end

  def email?
    true
  end

  def invite?
    true
  end
end
