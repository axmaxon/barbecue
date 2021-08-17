class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # Настройка для работы Девайза, когда юзер правит профиль
  # Если в данный момент выполняется девайсовский контроллер разрешаем параметры
  # для обновления регистрации пользователя (то же что делаем в каждом контроллере, но
  # специально для девайса)
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Хелпер будет доступен во всех вьюхах
  helper_method :current_user_can_edit?

  # Настройка для девайза — разрешаем обновлять профиль, но обрезаем
  # параметры, связанные со сменой пароля.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [:password, :password_confirmation, :current_password]
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
    redirect_to(request.referrer || root_path)
  end
end
