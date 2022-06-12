class CommentPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    owner?(record)
  end

  private

  def owner?(comment)
    user.present? &&
      #owner of comment or owner of event
      ((comment.try(:user) == user) || (comment.event.try(:user) == user))
  end
end
