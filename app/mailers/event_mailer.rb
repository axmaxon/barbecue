# require 'open-uri'
# Письма о событиях
class EventMailer < ApplicationMailer
  # Письмо о новой подписке для автора события. В параметрах передаём то что необходимо
  # для составления текста письма.
  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    # Метод формирует письмо: to: - на какой email отправляется письмо, др. поля - на выбор.
    # (subject:, from:, )
    mail to: event.user.email, subject: default_i18n_subject(event_title: event.title)
  end

  # Письмо о новом комментарии на заданный email
  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: default_i18n_subject(event_title: event.title)
  end

  # Письмо о добавлении новой фотографии к событию
  def photo(event, photo, email)
    @event = event
    @photo = photo

    mail to: email, subject: default_i18n_subject(event_title: event.title)
  end
end
