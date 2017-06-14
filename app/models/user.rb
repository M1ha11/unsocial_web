class User < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_interrelationship, class_name:  "Interrelationship",
                                    foreign_key: "follower_id",
                                    dependent:   :destroy
  has_many :passive_interrelationship, class_name:  "Interrelationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :following, through: :active_interrelationship, source: :followed
  has_many :followers, through: :passive_interrelationship, source: :follower

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  validates_integrity_of  :avatar
  validates_processing_of :avatar

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
