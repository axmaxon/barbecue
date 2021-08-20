class EventPolicy < ApplicationPolicy
  def show?
    return true if record.pincode.blank? || user_is_owner?(record)
    return true if pincode_is_correct?(record)
    false
  end

  def edit?
    update?
  end

  def create?
    user.present?
  end

  def update?
    user_is_owner?(record)
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def user_is_owner?(event)
    user.present? && (event.user == user)
  end

  # Проверяем, верный ли в куках пин-код
  def pincode_is_correct?(event)
    event.pincode == cookies["events_#{event.id}_pincode"]
  end
end
