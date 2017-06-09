class Album < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  default_scope -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 140 }
end
