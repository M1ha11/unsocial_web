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

FactoryGirl.define do
  factory :interrelationship do
    association :user, strategy: :build
  end
end
