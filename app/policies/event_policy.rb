class EventPolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def create?
    new?
  end

  def edit?
    update?
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

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope
    end
  end
end
