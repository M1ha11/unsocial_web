class Notifications::NotifyComment < Notifications::AbstractNotification
  def initialize(comment)
    @reciever = comment.photo.album.user
    @transmitter = comment.user
    @comment = comment
  end

  def notify
    return if reciever == transmitter
    ActivityChannel.broadcast_to(reciever, {
        name: transmitter.first_name + " " + transmitter.last_name,
        avatar: transmitter.avatar.url,
        text: 'Comment your photo',
        url: user_album_photo_path(reciever, comment.photo.album, comment.photo)
    })
  end

  private

  attr_reader :comment
end
