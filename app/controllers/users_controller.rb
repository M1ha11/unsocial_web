class UsersController < ApplicationController
  before_action :user

  def show
    @albums = @user.albums
    @following = @user.following
    @followers = @user.followers
  end

  private

  def user
    @user = User.find(params[:id])
  end
end
