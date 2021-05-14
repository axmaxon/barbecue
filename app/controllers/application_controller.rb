class ApplicationController < ActionController::Base
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

  # Вспомогательный метод, возвращает true, если текущий залогиненный юзер
  # может править указанное событие
  def current_user_can_edit?(event)
    user_signed_in? && event.user == current_user
  end
end
