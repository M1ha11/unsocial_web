class Notifications::NotifyFollower < Notifications::AbstractNotification
  def initialize(interrelationship)
    @receiver = User.find(interrelationship.followed_id)
    @transmitter = User.find(interrelationship.follower_id)
  end

  def notify
    return if receiver == transmitter
    EventsMailer.follower_mail(transmitter, receiver).deliver_later
    ActivityChannel.broadcast_to(receiver, {
        name: transmitter.display_name,
        avatar: transmitter.avatar.url,
        text: 'Now following you',
        url: user_path(transmitter)
    })
  end
end
