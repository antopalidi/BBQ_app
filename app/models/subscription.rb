class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :event, presence: true
  validates :user_name, presence: true
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
  validates :user, uniqueness: { scope: :event_id }
  validates :user_email, uniqueness: { scope: :event_id }

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end
end
