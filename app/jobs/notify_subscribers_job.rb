class NotifySubscribersJob < ApplicationJob
  queue_as :default

  def perform(record)
    event = record.event

    if record.instance_of?(Subscription)
      EventMailer.subscription(record).deliver_later
      return
    end

    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [record.user&.email]).uniq

    if record.instance_of?(Comment)
      all_emails.each { |mail| EventMailer.comment(record, mail).deliver_later }
    elsif record.instance_of?(Photo)
      all_emails.each { |mail| EventMailer.photo(record, mail).deliver_later }
    end
  end
end
