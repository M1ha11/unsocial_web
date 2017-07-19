class Notifications::NotifyFollower < Notifications::AbstractNotification
  def initialize(interrelationship)
    @reciever = User.find(interrelationship.followed_id)
    @transmitter = User.find(interrelationship.follower_id)
  end

  def notify
    return if reciever == transmitter
    EventsMailer.follower_mail(transmitter, reciever).deliver_later
    ActivityChannel.broadcast_to(reciever, {
        name: transmitter.first_name + " " + transmitter.last_name,
        avatar: transmitter.avatar.url,
        text: 'Now following you',
        url: user_path(transmitter)
    })
  end
end
