class Photo < ApplicationRecord
  belongs_to :album
  mount_uploader :image, PictureUploader

  default_scope -> { order(created_at: :desc) }

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 140 }

  # Image Validation
  validates_integrity_of  :image
  validates_processing_of :image

  def image_size_validation
    errors[:image] << "should be less than 20MB" if avatar.size > 20.megabytes
  end
end
