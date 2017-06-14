class Photo < ApplicationRecord
  belongs_to :album
  has_many :comments, dependent: :destroy
  mount_uploader :image, PictureUploader

  default_scope -> { order(created_at: :desc) }

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 140 }

  # Image Validation
  validates_integrity_of  :image
  validates_processing_of :image
end
