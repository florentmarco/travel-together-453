class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  # TODO: everyone can send message?
  def create?
    true
  end
end
