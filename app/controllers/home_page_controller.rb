class HomePageController < ApplicationController
  def index
    if signed_in?
      @feed_photos = current_user.feed_photos.includes(album: :user).first(10).reverse
    end
  end
end
