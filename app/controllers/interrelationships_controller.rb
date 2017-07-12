class InterrelationshipsController < ApplicationController
  load_and_authorize_resource

  def create
    @interrelationship.save
    Notifications::NotifyFollower.new(@interrelationship).notify
  end

  def destroy
    @interrelationship.destroy
  end

  private

  def interrelationship_params
    params.permit(:followed_id)
  end
end
