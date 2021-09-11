class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    provider
  end

  def vkontakte
    provider
  end

  def provider
    # Дёргаем метод модели, который найдёт пользователя
    @user = User.from_omniauth(request.env['omniauth.auth'])
    provider = request.env['omniauth.auth'].provider

    # Если юзер есть, то логиним и редиректим на его страницу
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider)
      # Если неудачно, то c ошибкой редиректим на главную
    else
      flash[:error] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: provider,
        reason: 'authentication error'
      )
      redirect_to root_path
    end
  end
end
