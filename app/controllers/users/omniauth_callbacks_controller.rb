class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController


  def facebook
    @user = User.find_for_facebook_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Facebook')
      sign_in_and_redirect @user, event: :authentication
    else
      omniauth_failure
    end
  end

  private

  def omniauth_failure
    flash[:error] = I18n.t('omniauth.failure')
    redirect_to new_user_registration_path
  end
end
