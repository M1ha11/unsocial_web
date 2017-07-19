class EventsMailer < ApplicationMailer
  default from: 'unsocialweb@example.com'

  def follower_mail(transmitter, reciever)
    @reciever = reciever
    @transmitter = transmitter
    mail(to: reciever.email, subject: "#{transmitter.display_name} is now following you")
  end
end
