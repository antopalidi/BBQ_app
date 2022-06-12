class CommentsController < ApplicationController
  before_action :set_event, only: %i[create destroy]
  before_action :set_comment, only: [:destroy]

  after_action :verify_authorized, only: [:destroy]

  def create
    @new_comment = @event.comments.build(comment_params)

    authorize @new_comment

    @new_comment.user = current_user

    if @new_comment.save
      NotifySubscribersJob.perform_later(@new_comment)
      redirect_to @event, notice: I18n.t('controllers.comments.created')
    else
      render 'events/show', alert: I18n.t('controllers.comments.error')
    end
  end

  def destroy
    authorize @comment
    message = { notice: I18n.t('controllers.comments.destroyed') }

    @comment.destroy!

    redirect_to @event, message
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_comment
    @comment = @event.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_name)
  end
end
