class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_event, except: [:index, :new, :create]
  after_action :verify_authorized, except: [:index]
  after_action :verify_policy_scoped, only: :index

  # GET /events
  def index
    @events = policy_scope(Event)
  end

  # GET /events/1
  def show
    # При наличии в полученных параметрах валидного пинкода, записываем его в cookies
    write_down_pincode if params[:pincode].present? && @event.pincode_valid?(params[:pincode])

    authorize @event

    # В этом экшне перехватываем исключение от Pundit чтобы для неавторизованного юзера
    # рендерить форму ввода пинкода
    rescue Pundit::NotAuthorizedError
    flash.now[:alert] = I18n.t('controllers.events.wrong_pincode') if params[:pincode].present?
    render 'pincode_form'
  end

  # GET /events/new
  def new
    @event = current_user.events.build

    authorize @event
  end

  # GET /events/1/edit
  def edit
    authorize @event
  end

  # POST /events
  def create
    @event = current_user.events.build(event_params)

    authorize @event

    if @event.save
      redirect_to @event, notice: I18n.t('controllers.events.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    authorize @event

    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    authorize @event

    @event.destroy

    redirect_to events_url,
                notice: I18n.t('controllers.events.deleted', title: @event.title)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description, :pincode)
  end

  # Пишем пинкод в cookies в нужной форме, присваиваем значение и время существования
  def write_down_pincode
    cookies["events_#{@event.id}_pincode"] = { value: params[:pincode], expires: 1.minute }
  end
end
