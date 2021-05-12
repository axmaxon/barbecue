class ApplicationController < ActionController::Base
  # Настройка для работы Девайза, когда юзер правит профиль
  # Если в данный момент выполняется девайсовский контроллер разрешаем параметры
  # для обновления регистрации пользователя (то же что делаем в каждом контроллере, но
  # специально для девайса)
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [:password, :password_confirmation, :current_password]
    )
  end
end
