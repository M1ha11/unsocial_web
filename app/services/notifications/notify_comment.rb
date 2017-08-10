class Notifications::NotifyComment < Notifications::AbstractNotification
  def initialize(comment)
    @receiver = comment.photo.album.user
    @transmitter = comment.user
    @comment = comment
  end

  def notify
    return if receiver == transmitter
    ActivityChannel.broadcast_to(receiver, {
        name: transmitter.display_name,
        avatar: transmitter.avatar.url,
        text: 'Comment your photo',
        url: user_album_photo_path(receiver, comment.photo.album, comment.photo)
    })
  end

  private

  attr_reader :comment
end
