class CommentPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    user_is_owner?(record)
  end

  private

  def user_is_owner?(comment)
    #owner of comment or owner of event
    user.present? && ((comment.try(:user) == user) || (comment.event.try(:user) == user))
  end
end
