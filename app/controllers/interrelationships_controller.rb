class InterrelationshipsController < ApplicationController
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
    @interrelationship = Interrelationship.where(follower_id: current_user.id).where(followed_id: @user.id).first
    Notifications::NotifyFollower.new(@interrelationship).notify
    redirect_to @user
  end

  def destroy
    @user = Interrelationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
    redirect_to @user
  end
end
