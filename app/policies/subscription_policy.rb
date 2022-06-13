class SubscriptionPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    user_is_owner?(record)
  end

  private

  def user_is_owner?(subscription)
    #owner of subscription or owner of event
    user.present? && ((subscription.try(:user) == user) || (subscription.try(:event).try(:user) == user))
  end
end
