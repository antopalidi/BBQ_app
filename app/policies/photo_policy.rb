class PhotoPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    owner?(record)
  end

  private

  def owner?(photo)
    user.present? &&
      ((photo.user == user) || (photo.event.try(:user) == user))
  end
end
