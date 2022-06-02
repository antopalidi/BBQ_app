class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  helper_method :current_user_can_edit?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[password password_confirmation current_password]
    )
  end

  def set_locale
    I18n.locale = locale_from_url || I18n.default_locale
  end

  def locale_from_url
    locale = params[:locale]
    locale if I18n.available_locales.include?(locale.to_sym)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def current_user_can_edit?(model)
    user_signed_in? && (
      model.user == current_user ||
        (model.try(:event).present? && model.event.user == current_user)
    )
  end
end
