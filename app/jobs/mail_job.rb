class MailJob < ApplicationJob
  queue_as 'queue_my_social'

  def perform(transmitter, reciever)
    EventsMailer.follower_mail(transmitter, reciever)
  end
end
