class SubscriptionsController < ApplicationController
  # Задаем родительский event для подписки
  before_action :set_event, only: %i[create destroy]

  # Задаем подписку, которую юзер хочет удалить
  before_action :set_subscription, only: [:destroy]

  def create
    unless verify_recaptcha?(params[:recaptcha_token], 'checkout')
      return redirect_to event_path(@event.id), alert: I18n.t('controllers.subscriptions.you_look_like_a_bot')
    end

    # Болванка для новой подписки
    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user

    if @new_subscription.save

      # Если сохранилось, отправляем письмо
      # Пишем название класса, потом метода и передаём параметры
      # И доставляем методом .deliver_now (то есть в этом же потоке)
      EventMailer.subscription(@event, @new_subscription).deliver_now

      # Редиректим на страницу самого события
      redirect_to @event, notice: I18n.t('controllers.subscriptions.created')
    else
      # если ошибки — рендерим шаблон события
      render 'events/show', alert: I18n.t('controllers.subscriptions.error')
    end
  end

  def destroy
    message = { notice: I18n.t('controllers.subscriptions.destroyed') }
    if current_user_can_edit?(@subscription)
      @subscription.destroy
    else
      message = { alert: I18n.t('controllers.subscriptions.error') }
    end

    redirect_to @event, message
  end

  private

  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  # На события может подписаться не только анонимный пользователь, но и залогиненный.
  # Когда подписывается залогиненный, то нет смысла показывать форму, мы просто должны
  # показать, что подписка появилась. То есть параметр :subscription необязательный,
  # поэтому вместо require используем метод fetch:
  def subscription_params
    # .fetch разрешает в params отсутствие ключа :subscription
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end
end
