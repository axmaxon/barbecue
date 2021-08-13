class EventPolicy < ApplicationPolicy
  def show?
    super
  end

  def edit?
    super
  end

  def update?
    super
  end

  def destroy?
    super
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
