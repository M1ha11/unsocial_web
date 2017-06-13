class User < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_many :comments, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  # User Avatar Validation
  validates_integrity_of  :avatar
  validates_processing_of :avatar

  private

    def avatar_size_validation
      errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
    end
end
