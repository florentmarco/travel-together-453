class NotificationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
    scope.where(recipient: user, read_at: nil)
    end
  end

  def create?
    true
  end

  def index?
    true
  end

  def mark_as_read?
    true
  end
end
