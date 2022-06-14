class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook github]

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: { maximum: 35 }
  validates :email, length: { maximum: 255 }, uniqueness: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/

  class << self
    def find_for_facebook_oauth(access_token)
      find_for_oauth(access_token)
    end

    def find_for_github_oauth(access_token)
      find_for_oauth(access_token)
    end

    private

    def find_for_oauth(access_token)
      email = access_token.info.email

      user = where(email: email).first
      return user if user.present?

      provider = access_token.provider
      provider_id = access_token.extra.raw_info.id
      name = access_token.info.name

      where(provider_id: provider_id, provider: provider).first_or_create! do |user|
        user.name = name
        user.email = email
        user.password = Devise.friendly_token.first(16)
      end
    end
  end

  private

  def set_name
    self.name = "Товарисч №#{rand(777)}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
