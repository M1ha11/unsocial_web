class UsersController < ApplicationController
  before_action :find_user

  def show
    @albums = @user.albums
  end

  def following
    @title = "Following"
    @users = @user.following
    # render 'show_follow'
  end

  def followers
    @title = "Followers"
    @users = @user.followers
    # render 'show_follow'
  end

  private

    def find_user
      @user = User.find(params[:id])
    end
end
