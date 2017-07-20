# == Schema Information
#
# Table name: interrelationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_interrelationships_on_followed_id                  (followed_id)
#  index_interrelationships_on_follower_id                  (follower_id)
#  index_interrelationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#

class Interrelationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validate :cannot_follow_self

  private

  def cannot_follow_self
    if follower == followed
      errors.add(:followed_id, "can't be equal to follower")
    end
  end
end
