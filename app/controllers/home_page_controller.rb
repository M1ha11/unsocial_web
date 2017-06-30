class HomePageController < ApplicationController
  def index
    if signed_in?
       @feed_photos = Photo.where(albums: { user: current_user.following }).includes(:album).first(10)
    end
  end
end
