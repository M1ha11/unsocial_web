class InterrelationshipsController < ApplicationController
  load_and_authorize_resource

  def create
    @interrelationship.save
    Notifications::NotifyFollower.new(@interrelationship).notify
    respond_with @interrelationship
  end

  def destroy
    @interrelationship.destroy
    respond_with @interrelationship
  end

  private

  def interrelationship_params
    params.permit(:followed_id)
  end
end
