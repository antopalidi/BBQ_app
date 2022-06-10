class EventPolicy < ApplicationPolicy
  def index?
    true
  end

  def edit?
    update?
  end

  def new?
    user.present?
  end

  def create?
    new?
  end

  def show?
    password_guard!(record)
  end

  def update?
    user_is_owner?(record)
  end

  def destroy?
    update?
  end

  private

  def user_is_owner?(event)
    user.present? && (event.try(:user) == user)
  end

  def password_guard!(event_context)
    return true if event_context.event.pincode.blank? || user.present? && user == event_context.event.user

    event_context.pincode.present? && event_context.event.pincode_valid?(event_context.pincode)
  end
end
