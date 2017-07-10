class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @albums = @user.albums
  end
end
