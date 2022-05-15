class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  with_options if: -> { user.present? } do
    validates :user, uniqueness: { scope: :event_id }
  end

  with_options unless: -> { user.present? } do
    validates :event, presence: true
    validates :user_name, presence: true
    validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
    validates :user, uniqueness: { scope: :event_id }
    validate :cannot_use_someone_email
  end

  validate :ban_subscriptions_to_own_event

  def user_name
    user.present? ? user.name : super
  end

  def user_email
    user.present? ? user.email : super
  end

  private

  def cannot_use_someone_email
    errors.add(:user_email, :wrong_email) if User.exists?(email: user_email)
  end

  def ban_subscriptions_to_own_event
    errors.add(:user_email, :creator_cant_subscribe) if event.user == user
  end
end
