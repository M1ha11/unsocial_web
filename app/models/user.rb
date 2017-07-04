# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  adress                 :string
#  avatar                 :string
#

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
