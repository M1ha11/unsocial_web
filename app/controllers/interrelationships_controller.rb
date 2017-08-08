class InterrelationshipsController < ApplicationController
  load_and_authorize_resource

  def create
    Notifications::NotifyFollower.new(@interrelationship).notify if @interrelationship.save
  end

  def destroy
    @interrelationship.destroy
  end

  private

  def interrelationship_params
    params.permit(:followed_id)
  end
end
