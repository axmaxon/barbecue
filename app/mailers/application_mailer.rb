class ApplicationMailer < ActionMailer::Base
  # Используются разные ящики для разных окружений (для dev/mailjet - yandex)
  # ()То же сделано в initializers/devise.rb)
  if Rails.env.production?
    default from: Rails.application.credentials.mailjet[:sender]
  else
    default from: Rails.application.credentials.gmail[:sender]
  end

  layout 'mailer'
end
