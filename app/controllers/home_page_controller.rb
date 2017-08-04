class HomePageController < ApplicationController
  def index
    if signed_in?
      @feed_photos = current_user.feed_photos.order(created_at: 'desc').includes(album: :user).first(10)
    end
  end
end
