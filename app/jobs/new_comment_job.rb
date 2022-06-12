class NewCommentJob < ApplicationJob
  queue_as :default

  def perform(event, comment, email)
    EventMailer.comment(event, comment, email).deliver_later
  end
end
