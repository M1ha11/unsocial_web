class HomePageController < ApplicationController
  def index
    if signed_in?
      @user = current_user
      @albums = current_user.albums
    end
  end
end
