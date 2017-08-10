class EventsMailer < ApplicationMailer
  default from: 'unsocialweb@example.com'

  def follower_mail(transmitter, receiver)
    @receiver = receiver
    @transmitter = transmitter
    mail(to: receiver.email, subject: "#{transmitter.display_name} is now following you")
  end
end
