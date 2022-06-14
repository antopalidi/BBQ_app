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

  def github
    @user = User.find_for_github_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Github')
      sign_in_and_redirect @user, event: :authentication
    else
      session['device.github_data'] = request.env['omniauth.auth'].except('extra')
      omniauth_failure
    end
  end

  private

  def omniauth_failure
    flash.now[:alert] = I18n.t('omniauth.failure')
    redirect_to new_user_registration_path
  end
end
