class VotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  # TODO: should everyone can vote?
  def create?
    true
  end

  # TODO: should everyone can destroy?
  def destroy?
    true
  end
end
