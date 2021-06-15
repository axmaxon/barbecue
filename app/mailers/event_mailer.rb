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
    mail to: event.user.email, subject: "#{I18n.t('event_mailer.subscription.title')} #{event.title}"
  end

  # Письмо о новом комментарии на заданный email
  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: "#{I18n.t('event_mailer.comment.title')} #{event.title}"
  end

  # Письмо о добавлении новой фото к событию
  def photo(event, photo, email)
    @event = event
    @photo = photo

    attachments.inline['picture.jpg'] = File.read("public#{photo.photo.url}")

    mail to: email, subject: "#{ I18n.t('event_mailer.photo.title')} #{event.title}"
  end
end
