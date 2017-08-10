class Notifications::AbstractNotification
  include Rails.application.routes.url_helpers

  def notify
    raise NotImplementedError
  end

  protected

  attr_reader :receiver, :transmitter
end
