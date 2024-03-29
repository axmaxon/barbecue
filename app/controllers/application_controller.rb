class ApplicationController < ActionController::Base
  include Pundit
  # recaptcha v3 возвращает оценку по шкале от 0 (точно бот) до 1 (точно человек)
  # в данной переменной устанавливается приемлемый уровень успешного прохождения верификации
  RECAPTCHA_MINIMUM_SCORE = 0.5
  # Настройка для работы Девайза, когда юзер правит профиль
  # Если в данный момент выполняется девайсовский контроллер разрешаем параметры
  # для обновления регистрации пользователя (то же что делаем в каждом контроллере, но
  # специально для девайса)
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Хелпер будет доступен во всех вьюхах
  helper_method :current_user_can_edit?

  # Отправляет запрос на подтверждение на Google reCaptcha api
  def verify_recaptcha?(token, recaptcha_action)
    require 'net/https'
    secret_key = Rails.application.credentials.google_recaptcha[:secret_key]

    uri = URI.parse("https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{token}")
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)
    json['success'] && json['score'] > RECAPTCHA_MINIMUM_SCORE && json['action'] == recaptcha_action
  end

  # Настройка для девайза — разрешаем обновлять профиль, но обрезаем
  # параметры, связанные со сменой пароля.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[password password_confirmation current_password]
    )
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def current_user_can_edit?(model)
    # Если у модели есть юзер и он залогиненный, пробуем у неё взять .event
    # Если он есть, проверяем его юзера на равенство current_user.
    user_signed_in? && (
      model.user == current_user ||
        (model.try(:event).present? && model.event.user == current_user)
    )
  end

  # Переопределяем пользовательскую запись которую будет использовать pundit, с помощью
  # экземпляра класса UserContext (созданного для этих целей)
  def pundit_user
    PunditUser.new(current_user, cookies)
  end

  private

  def user_not_authorized
    # flash[:warning] = t('pundit.not_authorized')
    flash[:alert] = t('pundit.not_authorized')
    redirect_to(request.referer || root_path)
  end
end
