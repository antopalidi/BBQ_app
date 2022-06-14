class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_event, only: %i[destroy edit show update]
  after_action :verify_authorized, only: %i[destroy edit show update]

  def index
    @events = Event.includes(%i[user subscriptions subscribers]).all
    @coordinates = Gmaps4rails.build_markers(@events) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
    end
  end

  def show
    pincode = params[:pincode] || cookies.permanent["events_#{@event.id}_pincode"]

    event_context = EventContext.new(event: @event, pincode: pincode)
    authorize event_context, policy_class: EventPolicy

    cookies.permanent["events_#{@event.id}_pincode"] = pincode

    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photo = @event.photos.build(params[:photo])
    @coordinates = Gmaps4rails.build_markers(@event) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
    end

  rescue Pundit::NotAuthorizedError
    render_password_form
  end

  def new
    @event = current_user.events.build
    authorize @event
  end

  def edit
    authorize @event
  end

  def create
    @event = current_user.events.build(event_params)
    authorize @event

    if @event.save
      redirect_to @event, notice: I18n.t('controllers.events.created')
    else
      render :new
    end
  end

  def update
    authorize @event

    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.updated')
    else
      render :edit
    end
  end

  def destroy
    authorize @event
    @event.destroy
    redirect_to events_url, alert: I18n.t('controllers.events.destroyed')
  end

  private

  def render_password_form
    flash.now[:alert] = I18n.t('controllers.events.wrong_pincode') if params[:pincode].present?
    render 'password_form'
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description, :pincode)
  end
end
